//
//  CJHTYAdvertView.h
//  cjh
//
//  Created by 杨飞 on 16/12/8.
//  Copyright © 2016年 njcjh. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^BtnTouchBlock)();
@interface CJHTYAdvertView : UIView
- (id)initWithFrame:(CGRect)frame withBtnTouchBlock:(BtnTouchBlock)btnTouchBlock;
@end
