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

@interface DZRArtistSearchViewController () <UICollectionViewDataSource, UICollectionViewDelegate, UISearchBarDelegate>

@property (nonatomic, weak) IBOutlet UICollectionView *collectionView;
@property (nonatomic, weak) IBOutlet UISearchBar *searchBar;
@property (nonatomic, strong) NSArray *artists;

@end

@implementation DZRArtistSearchViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
    
    [DZRServiceController searchArtistWithName:name compeletion:^(NSArray *artists, NSError *error) {
        self.artists = artists;
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
    return self.artists.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"ArtistCollectionViewCellIdentifier";

    DZRArtistCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
    DZRArtist *artist = [self.artists objectAtIndex:indexPath.row];
    [cell.artistImage setImageWithURL:[NSURL URLWithString:artist.artistPictureUrl] placeholder:[UIImage imageNamed:@""] success:nil failure:nil];
    cell.artistName.text = artist.artistName;
    return cell;
}

@end
