//
//  DZRArtistDetailViewController.m
//  DeezerExercice
//
//  Created by Ce Yang on 10/06/2015.
//  Copyright (c) 2015 Deezer. All rights reserved.
//

#import "DZRArtistDetailViewController.h"
#import "UIImageView+DZRImageFetcher.h"
#import "DZRServiceController.h"
#import "DZRTrackTableViewCell.h"
#import "DZRTrack.h"
#import <AVFoundation/AVFoundation.h>

@interface DZRArtistDetailViewController () <UITableViewDataSource, UITableViewDelegate,AVAudioPlayerDelegate>

@property (nonatomic, weak) IBOutlet UIImageView *thumbnail;
@property (nonatomic, weak) IBOutlet UILabel *fansNumberLabel;
@property (nonatomic, weak) IBOutlet UILabel *albumsNumberLabel;
@property (nonatomic, weak) IBOutlet UITableView *topAlbumTableView;

@property (nonatomic, strong) NSArray *trackList;

@property (nonatomic, strong) AVAudioPlayer *audioPlayer;

@end

@implementation DZRArtistDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = self.artist.artistName;
    
    if (self.artist.artistAlbumNumber == 1) {
        self.albumsNumberLabel.text = @"1 album";
    } else {
        self.albumsNumberLabel.text = [NSString stringWithFormat:@"%li albums", self.artist.artistAlbumNumber];
    }
    
    if (self.artist.artistFanNumber == 1) {
        self.fansNumberLabel.text = @"1 fan";
    } else {
        self.fansNumberLabel.text = [NSString stringWithFormat:@"%li fans",self.artist.artistFanNumber];
    }
    
    if (self.artist.artistPictureUrl) {
        [self.thumbnail setImageWithURL:[NSURL URLWithString:self.artist.artistPictureUrl] placeholder:nil success:nil failure:nil];
    }
    
    [self.topAlbumTableView registerNib:[UINib nibWithNibName:NSStringFromClass([DZRTrackTableViewCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([DZRTrackTableViewCell class])];
    
    self.trackList = [NSMutableArray array];
    [self fetchTopAlbumList];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)fetchTopAlbumList {
    [DZRServiceController fetchTopTrackListWithArtistId:self.artist.artistIdentifier number:50 completion:^(id responseObject, NSError *error) {
        //Parse: just quick parse
        NSDictionary *topListDictionary = [responseObject objectForKey:@"data"];
        if (topListDictionary) {
            NSMutableArray *trackList = [NSMutableArray array];
            for (NSDictionary *aTrackDictionary in topListDictionary) {
                DZRTrack *aTrack = [[DZRTrack alloc] initWithDictionary:aTrackDictionary];
                [trackList addObject:aTrack];
            }
            self.trackList = trackList;
            [self.topAlbumTableView reloadData];
        }
    }];
}

#pragma mark - UITableView
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.trackList count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    DZRTrackTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([DZRTrackTableViewCell class])];
    [cell updateWithTrack:[self.trackList objectAtIndex:indexPath.item]];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80.f;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSError *error;
    DZRTrack *selectedTrack = [self.trackList objectAtIndex:indexPath.row];
    if (selectedTrack.trackPreview) {
        NSData *musicData = [NSData dataWithContentsOfURL:[NSURL URLWithString:selectedTrack.trackPreview]];
        self.audioPlayer = [[AVAudioPlayer alloc] initWithData:musicData error:&error];
        self.audioPlayer.delegate = self;
        if (nil == error) {
            [self.audioPlayer play];
        }
    }
}
@end
