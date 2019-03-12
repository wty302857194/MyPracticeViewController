//
//  ListSelectView.m
//  cjh
//
//  Created by wbb on 16/10/31.
//  Copyright © 2016年 njcjh. All rights reserved.
//

#import "ListSelectView.h"

@interface ListSelectView()<UITableViewDelegate,UITableViewDataSource>{
    CGFloat kSingleTitleHeight;
    CGFloat kSingleBtnHeight;
}
@property (strong, nonatomic) UIView *selectView;
@property (assign, nonatomic) CGFloat collectionViewHeight;
@property (strong, nonatomic) NSArray *titleArray;
@property (assign, nonatomic) BOOL isAnimated;
@property (nonatomic,copy)NSString *title_str;
//@property (copy,   nonatomic) dismissViewWithButton completionBlock;
//@property (copy,   nonatomic) SureButtonBlock sureButtonBlock;
@end
@implementation ListSelectView

- (instancetype _Nonnull)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    }
    return self;
}
- (void)addTitleArray:(NSArray<NSString *> * __nullable)titleArray andTitleString:(NSString *__nullable)titleStr animated:(BOOL)animated completionHandler:(dismissViewWithButton __nullable)completionHandler withSureButtonBlock:(SureButtonBlock __nullable)sureButtonBlock {
    
    self.titleArray = titleArray;
    self.isAnimated = animated;
    self.completionBlock = completionHandler;
    self.sureButtonBlock = sureButtonBlock;
    self.title_str = titleStr;
    [self setupHeight];
    if (!_isShowTitle) {
        kSingleTitleHeight = 0.f;
    }else{
        kSingleTitleHeight = 40.f;
    }
    if (_isShowSureBtn||_isShowCancelBtn) {
        kSingleBtnHeight = 50;
    }else {
        kSingleBtnHeight = 0;
    }
    [self initSelectView];
    
    
    if (self.isAnimated) {
        [self addPopAnimation];
    }
    
}
#pragma mark - setup methods

- (void)setupHeight {
    
    if(_choose_type == MORECHOOSETITLETYPE){
        self.collectionViewHeight = self.titleArray.count * kSingleSelectCellHeight;
    }else if (_choose_type == ONLYTEXTTYPE) {
        if (self.content_text.length>0) {
            self.collectionViewHeight = [Global heightForText:self.content_text textFont:kSingleContentTextFount standardWidth:kScreenWidth-80]+40;
        }
        if (self.attributedStr.length>0) {
            self.collectionViewHeight = [Global heightForText:[self.attributedStr string] textFont:14 standardWidth:kScreenWidth-80]+40;//这里后期优化
        }
        
    }
    
    if (self.collectionViewHeight + 200 > kScreenHeight) {
        self.collectionViewHeight = kScreenHeight-200;
    }
}

- (void)initSelectView {
    
    if (_proportion_count==0) {
        _proportion_count = 2/3.f;
    }
    self.selectView = [[UIView alloc]initWithFrame:CGRectMake(15, ((kScreenHeight-(self.collectionViewHeight+101))/2)*_proportion_count, kScreenWidth-30, self.collectionViewHeight+kSingleTitleHeight+kSingleBtnHeight+1)];
    self.selectView.backgroundColor = [UIColor whiteColor];
    self.selectView.layer.cornerRadius = 10;
    self.selectView.layer.shadowColor = [UIColor grayColor].CGColor;
    self.selectView.layer.shadowOffset = CGSizeMake(10, 10);
    self.selectView.layer.shadowOpacity = 0.5;
    self.selectView.layer.shadowRadius = 5;
    [self addSubview:self.selectView];
    /**
     标题Label
     */
    YKLabel *tilteLabel = [[YKLabel alloc]initWithFrame:CGRectMake(0, 0, self.selectView.frame.size.width, kSingleTitleHeight)];
    tilteLabel.verticalAlignment = YKLabelVerticalAlignmentModelBottom;
    tilteLabel.hidden = _isShowTitle?NO:YES;;
    tilteLabel.text = _title_str;//@"请选择适合的选项";
    tilteLabel.font = [UIFont systemFontOfSize:18.f];
    tilteLabel.textAlignment = NSTextAlignmentCenter;
    tilteLabel.textColor = _title_color?:hexColor(323232);
    [self.selectView addSubview:tilteLabel];
    /**
     横线
     */
//    UILabel *horizontal1 = [[UILabel alloc]initWithFrame:CGRectMake(0 , tilteLabel.frame.size.height-1, self.selectView.frame.size.width, 0.5)];
//    horizontal1.hidden = _isShowTitle?NO:YES;
//    horizontal1.backgroundColor = [UIColor grayColor];
//    [tilteLabel addSubview:horizontal1];
    
    if(_choose_type == MORECHOOSETITLETYPE) {
        /**
         *  注册tableview
         */
        UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, kSingleTitleHeight, self.selectView.frame.size.width, self.collectionViewHeight) style:UITableViewStylePlain];
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        tableView.backgroundColor = [UIColor whiteColor];
        tableView.delegate = self;
        tableView.dataSource = self;
        [self.selectView addSubview:tableView];
    }else {
        /**
         注册contentLabel
         */
        _lab_content = [[YKLabel alloc] initWithFrame:CGRectMake(20, kSingleTitleHeight, self.selectView.frame.size.width-40, self.collectionViewHeight)];
        
        _lab_content.numberOfLines = 0;
        _lab_content.font = [UIFont systemFontOfSize:kSingleContentTextFount];
        _lab_content.textColor = _content_text_color?:hexColor(323232);
        if (self.content_text.length>0) {
            _lab_content.text = self.content_text;
        }
        if (self.attributedStr.length>0) {
            _lab_content.attributedText = self.attributedStr;
            
        }
//        _lab_content.lineSpaceing = 10.f;
        [self.selectView addSubview:_lab_content];
    }
    
    /**
     取消Button
     */
    
    UIButton *cancelButton = [[UIButton alloc]initWithFrame:CGRectMake(0, self.selectView.frame.size.height-50,_isShowSureBtn&&_isShowCancelBtn?self.selectView.frame.size.width/2-1: self.selectView.frame.size.width, kSingleBtnHeight)];
    [cancelButton setTitle:_cancelBtn_title?:@"取 消" forState:UIControlStateNormal];
    [cancelButton setTitleColor:_cancelBtn_title_color?:hexColor(323232) forState:UIControlStateNormal];
    cancelButton.titleLabel.font = [UIFont systemFontOfSize:18];
    cancelButton.hidden = _isShowCancelBtn?NO:YES;
    [cancelButton addTarget:self action:@selector(cancelButtonAction) forControlEvents:UIControlEventTouchDown];
    [self.selectView addSubview:cancelButton];
    /**
     确定Button
     */
    UIButton *okButton = [[UIButton alloc]initWithFrame:CGRectMake(_isShowSureBtn&&_isShowCancelBtn?self.selectView.frame.size.width/2+1:0, self.selectView.frame.size.height-50, _isShowSureBtn&&_isShowCancelBtn?self.selectView.frame.size.width/2-1: self.selectView.frame.size.width, kSingleBtnHeight)];
    okButton.hidden = _isShowSureBtn?NO:YES;
    [okButton setTitle:_sureBtn_title?:@"确 定" forState:UIControlStateNormal];
    [okButton setTitleColor:_sureBtn_title_color?:hexColor(323232) forState:UIControlStateNormal];
    [okButton addTarget:self action:@selector(okButtonAction) forControlEvents:UIControlEventTouchDown];
    [self.selectView addSubview:okButton];
    /**
     竖线
     */
    UILabel *verticalline = [[UILabel alloc]initWithFrame:CGRectMake(cancelButton.frame.size.width, cancelButton.frame.origin.y, 0.5, cancelButton.frame.size.height)];
    verticalline.backgroundColor = [UIColor grayColor];
    verticalline.hidden = _isShowCancelBtn&&_isShowSureBtn?NO:YES;
    [self.selectView addSubview:verticalline];
    /**
     横线
     */
    UILabel *horizontal2 = [[UILabel alloc]initWithFrame:CGRectMake(0 , cancelButton.frame.origin.y-1, self.selectView.frame.size.width, 0.5)];
    horizontal2.hidden = _isShowCancelBtn||_isShowSureBtn?NO:YES;
    horizontal2.backgroundColor = [UIColor grayColor];
    [self.selectView addSubview:horizontal2];
    
}

#pragma mark listViewdataSource method and delegate method
- (NSInteger)tableView:(UITableView *)table numberOfRowsInSection:(NSInteger)section
{
    return self.titleArray.count;
}
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellid=@"listviewid";
    UITableViewCell* cell=[tableView dequeueReusableCellWithIdentifier:cellid];
    if(cell==nil){
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault
                                   reuseIdentifier:cellid];
        
        UILabel *lab = [[UILabel alloc] init];
        lab.text = self.titleArray[indexPath.row];
        lab.textAlignment = NSTextAlignmentCenter;
        lab.font = [UIFont systemFontOfSize:18.f];
        [cell.contentView addSubview:lab];
        [lab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(cell.mas_centerX);
            make.centerY.mas_equalTo(cell.mas_centerY);
        }];
        
    }
   
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return kSingleSelectCellHeight;
}
//当选择下拉列表中的一行时，设置文本框中的值，隐藏下拉列表
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    for (UILabel *lab in cell.contentView.subviews) {
        if (self.completionBlock) {
            self.completionBlock(lab.text,indexPath.row);
        }
    }
    [self removeFromSuperview];
}

#pragma make - Action

- (void)cancelButtonAction {
    [self removeFromSuperview];
    
}
- (void)okButtonAction {
    self.sureButtonBlock();
    [self removeFromSuperview];
}
#pragma make - Animation

- (void)addPopAnimation {
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    animation.fromValue = [NSNumber numberWithDouble:0.f];
    animation.toValue   = [NSNumber numberWithDouble:1.f];
    animation.duration  = .25f;
    animation.fillMode  = kCAFillModeBackwards;
    [self.layer addAnimation:animation forKey:nil];
}
@end
