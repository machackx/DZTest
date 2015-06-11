//
//  DZRTrackTableViewCell.h
//  DeezerExercice
//
//  Created by Ce Yang on 11/06/2015.
//  Copyright (c) 2015 Deezer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DZRTrack.h"

@interface DZRTrackTableViewCell : UITableViewCell

@property (nonatomic, weak) IBOutlet UIImageView *albumImage;
@property (nonatomic, weak) IBOutlet UILabel *titleLabel;
@property (nonatomic, weak) IBOutlet UILabel *durationLabel;

-(void) updateWithTrack:(DZRTrack *) track;

@end
