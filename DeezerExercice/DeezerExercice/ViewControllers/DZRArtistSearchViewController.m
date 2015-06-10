//
//  DZRArtistSearchViewController.m
//  ;
//  Copyright (c) 2015 Deezer. All rights reserved.
//

#import "DZRArtistSearchViewController.h"
#import "DZRArtistCollectionViewCell.h"
#import "DZRServiceController.h"
#import "DZRArtist.h"
#import "UIImageView+DZRImageFetcher.h"
#import "DZRLoadingCell.h"

#define SCREEN_WIDTH [[UIScreen mainScreen] bounds].size.width

static const CGFloat DZRPaginatedLoadScrollViewThreshold = 40.f;

@interface DZRArtistSearchViewController () <UICollectionViewDataSource, UICollectionViewDelegate, UISearchBarDelegate>

@property (nonatomic, weak) IBOutlet UICollectionView *collectionView;
@property (nonatomic, weak) IBOutlet UISearchBar *searchBar;
@property (nonatomic, strong) NSArray *artists;

//Flag to test if we should load more content or not
@property (nonatomic, assign) BOOL canLoadMoreContent;
@property (nonatomic, assign) NSUInteger lastLoadedPageIndex;
@property (nonatomic, assign) NSUInteger totalNumber;
@property (nonatomic, assign) BOOL isLoading;

@end

@implementation DZRArtistSearchViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Register loading cell
    [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([DZRLoadingCell class]) bundle:nil] forCellWithReuseIdentifier:NSStringFromClass([DZRLoadingCell class])];
    
    UICollectionViewFlowLayout *flowLayout = (UICollectionViewFlowLayout *)self.collectionView.collectionViewLayout;
    //Simple calculation to make sure the space between the cell is equal
    CGFloat space = 30.f;
    // v|-space-cell-space-cell-space-|
    CGFloat cellWidth = (SCREEN_WIDTH - space * 3)/2;
    CGFloat cellHeight = cellWidth + 40;
    
    flowLayout.itemSize = CGSizeMake(cellWidth, cellHeight);
    flowLayout.sectionInset = UIEdgeInsetsMake(10.f, 30.f, 10.f, 30.f);
    self.collectionView.collectionViewLayout = flowLayout;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - Search

- (void)searchArtistsWithName:(NSString *)name {
    
    [DZRServiceController searchArtistWithName:name compeletion:^(id responseObject, NSError *error) {
        NSMutableArray *artistList = [NSMutableArray new];
        NSArray *artistDictionary = [responseObject valueForKey:@"data"];
        //Parse the raw JSON data
        for (NSDictionary *artists in artistDictionary) {
            DZRArtist *artist = [[DZRArtist alloc] initWithDictionary:artists];
            [artistList addObject:artist];
        }
        self.artists = artistList;
        self.totalNumber = (NSUInteger)[[responseObject valueForKey:@"total"] integerValue];
        self.lastLoadedPageIndex = [self.artists count];
        self.canLoadMoreContent = [artistDictionary count] < self.totalNumber;
        [self.collectionView reloadData];
    }];
}

#pragma mark - UISearchBarDelegate

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    [self searchArtistsWithName:searchText];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [searchBar resignFirstResponder];
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    //Add one cell which contains a loader for pagination
    if ([self.artists count] < self.totalNumber) {
        return self.artists.count + 1;
    } else {
        return self.artists.count;
    }
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"ArtistCollectionViewCellIdentifier";

    UICollectionViewCell *aCell = nil;
    if (indexPath.item < [self.artists count]) {
        DZRArtistCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
        DZRArtist *artist = [self.artists objectAtIndex:indexPath.row];
        [cell.artistImage setImageWithURL:[NSURL URLWithString:artist.artistPictureUrl] placeholder:[UIImage imageNamed:@"placeholder"] success:nil failure:nil];
        cell.artistName.text = artist.artistName;
        aCell = cell;
    } else {
        DZRLoadingCell *loadingCell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([DZRLoadingCell class]) forIndexPath:indexPath];
        aCell = loadingCell;
    }
    return aCell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
}

//Pagination
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    if ([self shouldLoadMoreContentForScrollView:scrollView]) {
        [self loadMoreContent];
    }
}

-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    if ([self shouldLoadMoreContentForScrollView:scrollView]) {
        [self loadMoreContent];
    }
}

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    if (self.searchBar.isFirstResponder) {
        [self.searchBar resignFirstResponder];
    }
}

#pragma mark - private methods
-(BOOL)shouldLoadMoreContentForScrollView:(UIScrollView *)scrollView {
    BOOL isAtEndOfScrollView = scrollView.contentOffset.y + scrollView.bounds.size.height + DZRPaginatedLoadScrollViewThreshold >= scrollView.contentSize.height;
    return isAtEndOfScrollView && self.canLoadMoreContent;
}

-(void)loadMoreContent{
    if (self.lastLoadedPageIndex == [self.artists count]) {
        if (!self.isLoading) {
            self.isLoading = YES;
            [DZRServiceController searchArtistWithName:self.searchBar.text index:self.lastLoadedPageIndex compeletion:^(id responseObject, NSError *error) {
                NSMutableArray *artistList = [NSMutableArray arrayWithArray:self.artists];
                NSArray *artistDictionaryList = [responseObject valueForKey:@"data"];
                self.lastLoadedPageIndex += [artistDictionaryList count];
                //Parse the raw JSON data
                for (NSDictionary *artists in artistDictionaryList) {
                    DZRArtist *artist = [[DZRArtist alloc] initWithDictionary:artists];
                    [artistList addObject:artist];
                }
                self.artists = [artistList copy];
                //Reset flag
                self.canLoadMoreContent = [artistDictionaryList count] < self.totalNumber;
                self.isLoading = NO;
                [self.collectionView reloadData];
            }];
        }
    }
}
@end
