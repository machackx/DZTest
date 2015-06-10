//
//  DZRArtistDetailViewController.m
//  DeezerExercice
//
//  Created by Ce Yang on 10/06/2015.
//  Copyright (c) 2015 Deezer. All rights reserved.
//

#import "DZRArtistDetailViewController.h"
#import "UIImageView+DZRImageFetcher.h"

@interface DZRArtistDetailViewController ()

@property (nonatomic, weak) IBOutlet UIImageView *thumbnail;
@property (nonatomic, weak) IBOutlet UILabel *fansNumberLabel;
@property (nonatomic, weak) IBOutlet UILabel *albumsNumberLabel;

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
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
