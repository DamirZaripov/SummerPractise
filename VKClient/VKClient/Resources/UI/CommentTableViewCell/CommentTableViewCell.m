//
//  CommentTableViewCell.m
//  VKClient
//
//  Created by Damir Zaripov on 14.07.2018.
//  Copyright © 2018 Damir Zaripov. All rights reserved.
//

#import "CommentTableViewCell.h"
#import "Comment.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "Helpers.h"

@implementation CommentTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.avatarImageView.layer.cornerRadius = self.avatarImageView.frame.size.height / 2;
    self.avatarImageView.clipsToBounds = true;
}

- (void) prepareWithComment:(Comment *)comment {
    Source *source = comment.source;
    
    [self.avatarImageView sd_setImageWithURL:source.avatarURL placeholderImage:[UIImage imageNamed:@"avatar"]];
    
    if (source.surname != nil) {
        self.nameLabel.text = [NSString stringWithFormat:@"%@ %@", source.name, source.surname];
    } else {
        self.nameLabel.text = source.name;
    }
    
    self.commentTextLabel.text = comment.text;
    self.dateLabel.text = DateString(comment.date);
}

@end
