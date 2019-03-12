//
//  FPMessageTableViewCell.m
//  cjh
//
//  Created by 杨飞 on 17/2/21.
//  Copyright © 2017年 njcjh. All rights reserved.
//

#import "FPMessageTableViewCell.h"

@implementation FPMessageTableViewCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        
    }
    return self;
}

- (void)initWithIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        
    }
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
