//
//  DZRTrackTableViewCell.m
//  DeezerExercice
//
//  Created by Ce Yang on 11/06/2015.
//  Copyright (c) 2015 Deezer. All rights reserved.
//

#import "DZRTrackTableViewCell.h"
#import "UIImageView+DZRImageFetcher.h"

@implementation DZRTrackTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void) updateWithTrack:(DZRTrack *) track;
{
    self.titleLabel.text = track.trackTitle;
    
    //Duration seconds to minutes
    if (track.trackDuration > 0) {
        self.durationLabel.text = [NSString stringWithFormat:@"%0.f m %li s", floor(track.trackDuration/60), track.trackDuration%60];
    }
    [self.albumImage setImageWithURL:[NSURL URLWithString:track.trackAlbum.albumCover] placeholder:[UIImage imageNamed:@"placeholder"] success:nil failure:nil];
}
@end
