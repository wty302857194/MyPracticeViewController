//
//  ListSelectView.h
//  cjh
//
//  Created by wbb on 16/10/31.
//  Copyright © 2016年 njcjh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YKLabel.h"
//枚举 1.选择列表提示框 2.仅仅是提示框
typedef NS_ENUM(NSInteger , CHOOSE_TYPE) {
    MORECHOOSETITLETYPE = 0,
    ONLYTEXTTYPE
};

static const CGFloat kSingleSelectCellHeight = 40;
//提示框内容的字体大小
static const CGFloat kSingleContentTextFount = 18;

typedef void (^dismissViewWithButton)(NSString *__nullable string,NSInteger index);
typedef void (^SureButtonBlock)();
@interface ListSelectView : UIView

@property(nonatomic) CHOOSE_TYPE choose_type;
// 是否显示标题
@property (nonatomic)BOOL isShowTitle;

//是否显示取消按钮
@property (nonatomic)BOOL isShowCancelBtn;

//是否显示确认按钮
@property (nonatomic)BOOL isShowSureBtn;

@property (nonatomic, strong)UIColor * _Nullable title_color;
// 仅仅是一个提示框时  提示的内容不能为空
@property (nonatomic, copy)NSString  * _Nonnull content_text;
@property(nonatomic , copy) NSMutableAttributedString * _Nonnull attributedStr;
@property (nonatomic, strong)UIColor * _Nullable content_text_color;
//取消按钮的字体颜色
@property (nonatomic, strong)UIColor * _Nullable cancelBtn_title_color;
//确认按钮的字体颜色
@property (nonatomic, strong)UIColor * _Nullable sureBtn_title_color;
//取消按钮的字体
@property (nonatomic, copy)NSString * _Nullable cancelBtn_title;
//确认按钮的字体
@property (nonatomic, copy)NSString * _Nullable sureBtn_title;

@property (nonatomic, strong)YKLabel * _Nullable lab_content;

@property (nonatomic, assign)float proportion_count;

@property (copy,   nonatomic) dismissViewWithButton _Nullable completionBlock;
@property (copy,   nonatomic) SureButtonBlock _Nullable sureButtonBlock;
//初始化方法 创建对象
- (instancetype _Nonnull)initWithFrame:(CGRect)frame;
/**
 *  使用默认点击事件
 *
 *  @param titleArray        数据源，用于设置标题
 *  @param sttitleStryle     标题
 *  @param completionHandler 选择列表提示框的block回调
 *  @param animated          是否使用动画
 *  @param sureButtonBlock   确认按钮的block回调
 *  @return                  JYSelectView对象
 */
- (void)addTitleArray:(NSArray<NSString *> * __nullable)titleArray andTitleString:(NSString *__nullable)titleStr animated:(BOOL)animated completionHandler:(dismissViewWithButton __nullable)completionHandler withSureButtonBlock:(SureButtonBlock __nullable)sureButtonBlock;
@end
