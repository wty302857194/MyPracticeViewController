//
//  TYFontLabel.m
//  MyPracticeViewController
//
//  Created by wbb on 2017/8/16.
//  Copyright © 2017年 cjh. All rights reserved.
//

#import "TYFontLabel.h"

@implementation TYFontLabel

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.font = [UIFont fontWithDevice:self.font.pointSize];
        
    }
    return self;
}

@end
