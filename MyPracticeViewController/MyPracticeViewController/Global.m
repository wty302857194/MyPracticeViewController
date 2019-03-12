//
//  Global.m
//  HomeCare
//
//  Created by Lawrence on 13-10-10.
//  Copyright (c) 2013年 ztesoft. All rights reserved.
//

#import "Global.h"
//#import "MBProgressHUD.h"

#include <ifaddrs.h>
#include <arpa/inet.h>

#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define SYSTEM_VERSION_LOWWER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedDescending)

#define SYSTEM_RUNS_IOS7_OR_LATER SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0")
#define DocumentsPath [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] // 沙盒路径

@implementation Global

//+ (id)checkNSStringIsNull:(id)stringId
//{
//    if (stringId) {
//        return stringId;
//    }else {
//         return @"";
//    }
//}
//
//+ (void)initViewControllerPageName:(UIViewController *)viewController
//{
//    ((BaseViewController *)viewController).currentClass = NSStringFromClass(viewController.class);
//}
//
//+ (void)setSubViewExternNone:(UIViewController *)viewController
//{
//#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 70000
//    if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0")) {
//        viewController.edgesForExtendedLayout = UIRectEdgeNone;
//        viewController.extendedLayoutIncludesOpaqueBars = NO;
//        viewController.modalPresentationCapturesStatusBarAppearance = NO;
//        viewController.navigationController.navigationBar.translucent = NO;
//        viewController.automaticallyAdjustsScrollViewInsets = NO;
//    }
//#endif
//}
//
//+ (void)promptMessage:(NSString *)message inView:(UIView *)view
//{
//    MBProgressHUD *hud;
//    if (view == nil) {
//        hud = [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].keyWindow animated:YES];
//    } else {
//        hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
//    }
//	
//	// Configure for text only and offset down
//	hud.mode = MBProgressHUDModeText;
//	hud.labelText = message;
//    hud.labelFont = [UIFont systemFontOfSize:14];
//	hud.margin = 10.f;
//	hud.yOffset = 0.f;
//	hud.removeFromSuperViewOnHide = YES;
//	
//	[hud hide:YES afterDelay:1];
//}

//+ (void)promptMessageYoffset:(CGFloat)yyOffset withMessage:(NSString *)message inView:(UIView *)view
//{
//    MBProgressHUD *hud;
//    if (view == nil) {
//        hud = [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].keyWindow animated:YES];
//    } else {
//        hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
//    }
//    
//    // Configure for text only and offset down
//    hud.mode = MBProgressHUDModeText;
//    hud.labelText = message;
//    hud.labelFont = [UIFont systemFontOfSize:14];
//    hud.margin = 10.f;
//    hud.yOffset = yyOffset;
//    hud.removeFromSuperViewOnHide = YES;
//    
//    [hud hide:YES afterDelay:1.3];
//}
//
//
//+ (void)promptDetailMessage:(NSString *)message inView:(UIView *)view
//{
//    MBProgressHUD *hud;
//    if (view == nil) {
//        hud = [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].keyWindow animated:YES];
//    } else {
//        hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
//    }
//    
//    // Configure for text only and offset down
//    hud.mode = MBProgressHUDModeText;
//    hud.detailsLabelText = message;
//    hud.labelFont = [UIFont systemFontOfSize:14];
//    hud.margin = 10.f;
//    hud.yOffset = 0.f;
//    hud.removeFromSuperViewOnHide = YES;
//    
//    [hud hide:YES afterDelay:1];
//
//}


/* 16进制颜色(html颜色值)字符串转为UIColor */
+ (UIColor *)hexStringToColor:(NSString *)stringToConvert
{
    NSString *cString = [[stringToConvert stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] lowercaseString];
    
    NSString *aString = nil;
    
    if ([cString length] < 6) return [UIColor blackColor];
    
    /* 去除"0X","#"等标识符 */
    if ([cString hasPrefix:@"0X"]) cString = [cString substringFromIndex:2];
    if ([cString hasPrefix:@"#"]) cString = [cString substringFromIndex:1];
    if ([cString length] == 8) {
        aString = [cString substringToIndex:1];
        cString = [cString substringFromIndex:2];
    } else {
        aString = @"ff";
    }
    
    NSRange range;
    range.location = 0;
    range.length = 2;
    NSString *rString = [cString substringWithRange:range];
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    unsigned int a, r, g, b;
    
    [[NSScanner scannerWithString:aString] scanHexInt:&a];
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float) r / 255.0f)
                           green:((float) g / 255.0f)
                            blue:((float) b / 255.0f)
                           alpha:((float) a / 255.0f)];
}

+ (NSString *)currentTime
{
    NSMutableDictionary *threadDictionary = [[NSThread currentThread] threadDictionary];
    NSDateFormatter *currentFormatter = threadDictionary[@"currentdateformatter"];
    if (!currentFormatter) {
        @synchronized(self) {
            if (!currentFormatter) {
                currentFormatter = [[NSDateFormatter alloc] init];
                [currentFormatter setDateFormat:@"yyyy-MM-dd'-'HH'h-'mm'm-'ss's'SSS"];
                threadDictionary[@"currentdateformatter"] = currentFormatter;
            }
        }
    }
    return [currentFormatter stringFromDate:[NSDate date]];
}

//时图显示
+ (NSString *)currentTimeFormat2
{
    NSMutableDictionary *threadDictionary = [[NSThread currentThread] threadDictionary];
    NSDateFormatter *currentFormatter = threadDictionary[@"currentdateformatter2"];
    if (!currentFormatter) {
        @synchronized(self) {
            if (!currentFormatter) {
                currentFormatter = [[NSDateFormatter alloc] init];
                [currentFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
                threadDictionary[@"currentdateformatter2"] = currentFormatter;
            }
        }
    }
    return [currentFormatter stringFromDate:[NSDate date]];
}

+ (NSString *)timeSp2String:(double)sp
{
    NSMutableDictionary *threadDictionary = [[NSThread currentThread] threadDictionary];
    NSDateFormatter *dateFormatter = threadDictionary[@"mydateformatter"];
    if(!dateFormatter){
        @synchronized(self){
            if(!dateFormatter){
                dateFormatter = [[NSDateFormatter alloc] init];
                [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
                threadDictionary[@"mydateformatter"] = dateFormatter;
            }
        }
    }
    
    NSString *accessTime = [dateFormatter stringFromDate:[NSDate dateWithTimeIntervalSince1970:sp/1000.0]];
    return accessTime;
}

+ (NSDate *)string2Date:(NSString *)src
{
    NSMutableDictionary *threadDictionary = [[NSThread currentThread] threadDictionary];
    NSDateFormatter *dateFormatter = threadDictionary[@"timeformatter"];
    if(!dateFormatter){
        @synchronized(self){
            if(!dateFormatter){
                dateFormatter = [[NSDateFormatter alloc] init];
                [dateFormatter setDateFormat:@"HH:mm"];
                threadDictionary[@"timeformatter"] = dateFormatter;
            }
        }
    }
    NSDate *resultDate = [dateFormatter dateFromString:src];
    return resultDate;
}

+ (NSDate *)retainStandardFormatDateWith:(NSDate *)date
{
    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Hong_Kong"];
    NSInteger frominterval = [timeZone secondsFromGMTForDate: date];
    return [date  dateByAddingTimeInterval: frominterval];
}

// 当前时间
+ (NSString *)currentDateString:(NSDate *)nowDate
{
    NSDateFormatter *_dateFormmtter = [[NSDateFormatter alloc] init];
    [_dateFormmtter setDateFormat:@"yyyy-MM-dd HH:mm"];
    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Hong_Kong"];
    [_dateFormmtter setTimeZone:timeZone];
    NSString *startDateString = [_dateFormmtter stringFromDate:nowDate];
    
    return [startDateString substringWithRange:NSMakeRange(0, 16)];
}


+ (NSInteger)numberOfDaysFromCurrentTime:(NSDate *)currentTime toEndTime:(NSDate *)endTime timeStringFormat:(NSString *)format
{
    // format可以形如： @"yyyy-MM-dd"
    NSTimeZone *localTimeZone = [NSTimeZone timeZoneWithName:@"Asia/Hong_Kong"];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setTimeZone:localTimeZone];
    [formatter setDateFormat:NSLocalizedString(format,nil)];
    
    // 时分秒转为00:00:00
    NSDate *currentDate = [formatter dateFromString:[formatter stringFromDate:currentTime]];
    NSDate *endDate = [formatter dateFromString:[formatter stringFromDate:endTime]];
    
    // 计算时间戳
    NSTimeInterval dToday = [currentDate timeIntervalSince1970];
    NSTimeInterval dNewDate = [endDate timeIntervalSince1970];
    
    NSInteger nSecs = (NSInteger)(dNewDate - dToday);
    NSInteger oneDaySecs = 24*3600;
    
    return nSecs / oneDaySecs;
}

// 获取IPAddress
+ (NSString *)getIPAddress
{
    NSString *address = @"";
    struct ifaddrs *interfaces = NULL;
    struct ifaddrs *temp_addr = NULL;
    int success = 0;
    
    // retrieve the current interfaces - returns 0 on success
    success = getifaddrs(&interfaces);
    if (success == 0) {
        // Loop through linked list of interfaces
        temp_addr = interfaces;
        while (temp_addr != NULL) {
            if( temp_addr->ifa_addr->sa_family == AF_INET) {
                // Check if interface is en0 which is the wifi connection on the iPhone
                if ([[NSString stringWithUTF8String:temp_addr->ifa_name] isEqualToString:@"en0"]) {
                    // Get NSString from C String
                    address = [NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in *)temp_addr->ifa_addr)->sin_addr)];
                }
            }
            
            temp_addr = temp_addr->ifa_next;
        }
    }
    
    // Free memory
    freeifaddrs(interfaces);
    
    return address;
}
// 获取软件的版本号
+ (NSString *)getSoftVersion
{
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    NSString *versionStr = infoDictionary[@"CFBundleShortVersionString"];
    NSLog(@"版本号－－－－%@",infoDictionary);
    return versionStr;
}

+ (BOOL)checkStringContainsASCIICode:(NSString *)checkString
{
    const char *ASCIIString = [checkString cStringUsingEncoding:NSASCIIStringEncoding];
    if (ASCIIString) {
        return YES;
    }else {
        return NO;
    }
}

// 根据文字大小和控件宽度计算控件高度
+ (CGFloat)heightForText:(NSString *)text textFont:(CGFloat)fontSize standardWidth:(CGFloat)controlWidth
{
    if ([text length]==0) {
        return 0;
    }else {
        NSDictionary *attrbute = @{NSFontAttributeName:[UIFont systemFontOfSize:fontSize]};
        return [text boundingRectWithSize:CGSizeMake(controlWidth, 2000) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attrbute context:nil].size.height;
    }
}

+ (CGFloat)widthForText:(NSString *)text textFont:(CGFloat)fontSize  standardHeight:(CGFloat)controlHeight
{
    if ([text length]==0) {
        return 0;
    }else {
        NSDictionary *attrbute = @{NSFontAttributeName:[UIFont systemFontOfSize:fontSize]};
        return  [text boundingRectWithSize:CGSizeMake(1000,controlHeight) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attrbute context:nil].size.width;
    }
}

+ (NSAttributedString *)customTextString:(NSString *)textStr withRange:(NSRange)temRange withAttributedType:(BOOL)attributedType
{
    NSMutableAttributedString *rateStr = [[NSMutableAttributedString alloc]initWithString:textStr];
    NSString *attributeName = nil;
    id attributeValue = nil;
    
    if (attributedType) {
        attributeName = NSFontAttributeName;
        attributeValue = [UIFont systemFontOfSize:18.f];
    }else {
        attributeName = NSForegroundColorAttributeName;
        attributeValue = [UIColor blackColor];
    }
    
    [rateStr addAttribute:attributeName value:attributeValue range:temRange];
    return rateStr;
}

// 自定义文本的大小和颜色

+ (NSAttributedString *)customizationTextString:(NSString *)textStr withRange:(NSRange)temRange withFontSize:(CGFloat)textFont withTextColor:(UIColor *)textColor withAttributedType:(BOOL)attributedType
{
    NSMutableAttributedString *rateStr = [[NSMutableAttributedString alloc]initWithString:textStr];
    NSString *attributeName = nil;
    id attributeValue = nil;
    
    if (attributedType) {
        // 字体大小
        attributeName = NSFontAttributeName;
        attributeValue = [UIFont systemFontOfSize:textFont];
    }else {
        // 颜色
        attributeName = NSForegroundColorAttributeName;
        attributeValue = textColor;
    }
    
    [rateStr addAttribute:attributeName value:attributeValue range:temRange];
    return rateStr;
}

+ (NSAttributedString *)customizationTextString:(NSString *)textStr withRange:(NSRange)temRange withFontSize:(CGFloat)textFont withTextColor:(UIColor *)textColor withAttributesArrayType:(NSInteger)attributedType
{
    NSMutableAttributedString *rateStr = [[NSMutableAttributedString alloc]initWithString:textStr];
    if (attributedType==0) {
        [rateStr addAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:textFont],NSForegroundColorAttributeName:textColor} range:temRange];
    }else {
        
    }
    return rateStr;
}

//
+ (NSString *)isBlankString:(NSString *)string
{
    if (string == nil || string == NULL)
    {
        return @"0";
    }else if ([string isKindOfClass:[NSNull class]]) {
        return @"0";
    }else if ([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0)
    {
        return @"0";
    }else {
        return string;
    }
}


+ (NSString *)stringDeleteString:(NSString *)str
{
    NSMutableString *str1 = [NSMutableString stringWithString:str];
    for (int i = 0; i < str1.length; i++) {
        unichar c = [str1 characterAtIndex:i];
        NSRange range = NSMakeRange(i, 1);
        if (c == ',') { //此处可以是任何字符
            [str1 deleteCharactersInRange:range];
            --i;
        }
    }
    NSString *newstr = [NSString stringWithString:str1];
    return newstr;
}

+ (BOOL)refrenceString:(NSString *)refrenceStr withContainSomeString:(NSString *)str;
{
    //字条串是否包含有某字符串
    if (refrenceStr==nil) {
        return NO;
    }else if ([refrenceStr length]==0) {
        return NO;
    }else {
        if ([refrenceStr rangeOfString:str].location == NSNotFound) {
            return NO;
        } else {
            return YES;
        }
    }
}

+ (NSString *)formatStringTo334WithSourceStr:(NSString *)sourceStr
{
    if ([sourceStr length]==0) {
        return @"";
    }
    
    NSMutableString *temString = [NSMutableString stringWithString:sourceStr];
    [temString insertString:@" " atIndex:0];
    
    NSMutableString *temp = [NSMutableString string];
    for(int i =0; i < temString.length; i++)
    {
        NSString *str = [temString substringWithRange:NSMakeRange(i, 1)];
        [temp appendString:str];
        if ((i+1) % 4 == 0&&i<11) {
            [temp appendString:@" "];
        }
    }
    
    NSRange r;
    r.location = 0;
    r.length = 1;
    [temp deleteCharactersInRange:r];
    // NSLog(@"delete---%@---",temp);
    return temp;
}

//  颜色转换为背景图片
+ (UIImage *)imageWithColor:(UIColor *)color
{
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

// 压缩图片
+ (UIImage *)imageWithImageSimple:(UIImage*)image scaledToSize:(CGSize)newSize
{
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(newSize.width, newSize.height), NO,[UIScreen mainScreen].scale);
    //    UIGraphicsBeginImageContextWithOptions(newSize, NO, 2.0);
    //UIGraphicsBeginImageContext(newSize);//根据当前大小创建一个基于位图图形的环境
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];//根据新的尺寸画出传过来的图片
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();//从当前环境当中得到重绘的图片
    UIGraphicsEndImageContext();//关闭当前环境
    
    newImage = [newImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    return newImage;
}

+ (NSArray *)getGifImageArray {
    NSMutableArray *idleImages = [[NSMutableArray alloc] init];
    //这块为你刷新时出现的gif图 需要循环添加到数组中
    for (NSUInteger i = 1; i <= 3; i++) {
        
        UIImage *temImage = [UIImage imageNamed:[NSString stringWithFormat:@"refresh_pic%ld",i]];
        UIImage *image = [Global imageWithImageSimple:temImage scaledToSize:CGSizeMake(30, 30)];
        [idleImages addObject:image];
    }
    return idleImages;
}
+ (NSArray *)getGifImageFirst {
    NSMutableArray *idleImages = [[NSMutableArray alloc] init];
    //这块为你刷新时出现的gif图 需要循环添加到数组中
    UIImage *temImage = [UIImage imageNamed:@"refresh_pic1"];
    UIImage *image = [Global imageWithImageSimple:temImage scaledToSize:CGSizeMake(30, 30)];
    [idleImages addObject:image];
    return idleImages;
}
+ (NSArray *)getGifImageSecond {
    NSMutableArray *idleImages = [[NSMutableArray alloc] init];
    //这块为你刷新时出现的gif图 需要循环添加到数组中
    UIImage *temImage = [UIImage imageNamed:@"refresh_pic1"];
    UIImage *image = [Global imageWithImageSimple:temImage scaledToSize:CGSizeMake(30, 30)];
    [idleImages addObject:image];
    return idleImages;
}

#pragma mark -- 地址url 转image ,image转base64遍码
+ (UIImage *)downloaderImg:(NSString *)urlStr
{
    __block UIImage *imageIcon = nil;
    if ([urlStr length]==0) {
        return imageIcon;
    }
    
    NSURL *url = [NSURL URLWithString:urlStr];
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url];
    NSError *downloadError = nil;
    NSData *imageData = [NSURLConnection sendSynchronousRequest:urlRequest returningResponse:nil error:&downloadError];
    
    if (downloadError == nil && imageData != nil) {
        imageIcon = [UIImage imageWithData:imageData];
    }else if (downloadError != nil){
        NSLog(@"Error happened = %@", downloadError);
    }else {
        NSLog(@"No data could get downloaded from the URL.");
    }

    return imageIcon;
}

+ (NSString *)encodeBase64WithImage:(UIImage *)origrinImage
{
    NSString *_encodedImageStr = @"";
    // 把图片转换为Base64的字符串
    if (!origrinImage) {
        return _encodedImageStr;
    }
    NSData *_data = UIImagePNGRepresentation(origrinImage);
    _encodedImageStr = [_data base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    return _encodedImageStr;
}

+ (UIImage *)decodedImageWithImageStr:(NSString *)origrinImageStr
{
    UIImage *_decodedImage =  nil;
    if ([origrinImageStr length]==0) {
        return _decodedImage;
    }
    // 把Base64的字符串转换为图片
    NSData *_decodedImageData   = [[NSData alloc] initWithBase64EncodedString:origrinImageStr options:NSDataBase64DecodingIgnoreUnknownCharacters];
    _decodedImage = [UIImage imageWithData:_decodedImageData];
    return _decodedImage;
}

#pragma mark -- tabbar 五个标的读取－－

+ (void)saveImageArray:(NSDictionary *)saveDataDic
{
    // 1.获得沙盒(document)路径 －－ 宏定义了 DocumentsPath
    NSString *filepath = [DocumentsPath stringByAppendingPathComponent:@"data.plist"];
    BOOL tabbarIconHave = [[NSFileManager defaultManager] fileExistsAtPath:filepath];
    
    if (tabbarIconHave)
    {
        NSLog(@"tabbarIconHave already have");
        // delete
        BOOL tabbarDele = [[NSFileManager defaultManager] removeItemAtPath:filepath error:nil];
        if (tabbarDele) {
            NSLog(@"tabbarDele dele success");
        }else {
            NSLog(@"tabbarDele dele fail");
        }
    }
    // 2.组装存储数据
    BOOL writeSuccess = [saveDataDic writeToFile:filepath atomically:YES];
    if (writeSuccess) {
        NSLog(@"tabbarDele write success");
    }else {
        NSLog(@"tabbarDele write fail");
    }
}

+ (NSDictionary *)readImageArray
{
    // 1.获得沙盒(document)路径 －－ 宏定义了 DocumentsPath
    NSString *filepath = [DocumentsPath stringByAppendingPathComponent:@"data.plist"];
    if (!filepath) {
        return nil;
    }
    // 2.读取数据
    NSDictionary *sourceDataDic = [[NSDictionary alloc] initWithContentsOfFile:filepath];
    return sourceDataDic;
}
//存储ordercode
+ (void)saveOrderCodeArray:(NSMutableDictionary *)saveDataDic
{
    // 1.获得沙盒(document)路径 －－ 宏定义了 DocumentsPath
    NSString *filepath = [DocumentsPath stringByAppendingPathComponent:@"orderCode.plist"];
//    BOOL tabbarIconHave = [[NSFileManager defaultManager] fileExistsAtPath:filepath];
    
//    if (tabbarIconHave)
//    {
//        NSLog(@"tabbarIconHave already have");
//        // delete
//        BOOL tabbarDele = [[NSFileManager defaultManager] removeItemAtPath:filepath error:nil];
//        if (tabbarDele) {
//            NSLog(@"tabbarDele dele success");
//        }else {
//            NSLog(@"tabbarDele dele fail");
//        }
//    }
    // 2.组装存储数据
    BOOL writeSuccess = [saveDataDic writeToFile:filepath atomically:YES];
    if (writeSuccess) {
        NSLog(@"tabbarDele write success");
    }else {
        NSLog(@"tabbarDele write fail");
    }
}
+ (NSMutableDictionary *)readOrderCodeArray
{
    // 1.获得沙盒(document)路径 －－ 宏定义了 DocumentsPath
    NSString *filepath = [DocumentsPath stringByAppendingPathComponent:@"orderCode.plist"];
    if (!filepath) {
        return nil;
    }
    // 2.读取数据
    NSMutableDictionary *sourceDataDic = [[NSMutableDictionary alloc] initWithContentsOfFile:filepath];
    return sourceDataDic?:[[NSMutableDictionary alloc] initWithCapacity:0];
}

+ (BOOL)jumpIphoneSettingPage:(UIView *)showOnView
{
    if (SYSTEM_VERSION_LOWWER_THAN_OR_EQUAL_TO(@"10.0")) {
        [[UIApplication sharedApplication] openURL:[[NSURL alloc] initWithString:@"prefs:root="]];
        return YES;
    } else {
        if (showOnView) {
            [Global promptMessage:@"请前往设置里去修改" inView:showOnView];
        }
        return NO;
    }
}

+ (void)openSettingsURLString
{
    NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
    if([[UIApplication sharedApplication] canOpenURL:url]) {
        [[UIApplication sharedApplication] openURL:url];
    }
}
+ (UIImageView *)bgImageViewWith:(CellType)type bgImageViewWithFrame:(CGRect)frame cellBgColor:(UIColor *)clolor{
//    float cellHeight = (height)?height:44;
    UIImageView * cellBackView = [[UIImageView alloc] initWithFrame:frame];
    cellBackView.backgroundColor = clolor;
//    cellBackView.frame = CGRectMake(4, 0, SCREEN_WIDTH - 8, cellHeight);
    
    switch (type) {
        case Normal:
        {
            
        }
            break;
            
        case Singel:
        {
            //            cellBackView.layer.cornerRadius = 8;
            //            cellBackView.layer.masksToBounds = YES;
            UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:cellBackView.bounds cornerRadius:8.0f];
            CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
            maskLayer.frame = cellBackView.bounds;
            maskLayer.path = maskPath.CGPath;
            cellBackView.layer.mask = maskLayer;
        }
            break;
        case TopFillet:
        {
            UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:cellBackView.bounds byRoundingCorners:UIRectCornerTopRight | UIRectCornerTopLeft cornerRadii:CGSizeMake(8, 8)];
            CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
            maskLayer.frame = cellBackView.bounds;
            maskLayer.path = maskPath.CGPath;
            cellBackView.layer.mask = maskLayer;
        }
            break;
        case BottomFillet:
        {
            UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:cellBackView.bounds byRoundingCorners:UIRectCornerBottomLeft | UIRectCornerBottomRight cornerRadii:CGSizeMake(8, 8)];
            CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
            maskLayer.frame = cellBackView.bounds;
            maskLayer.path = maskPath.CGPath;
            cellBackView.layer.mask = maskLayer;
        }
            break;
        case LeftFillet:
        {
            UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:cellBackView.bounds byRoundingCorners:UIRectCornerBottomLeft | UIRectCornerTopLeft cornerRadii:CGSizeMake(8, 8)];
            CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
            maskLayer.frame = cellBackView.bounds;
            maskLayer.path = maskPath.CGPath;
            cellBackView.layer.mask = maskLayer;
        }
            break;
        case RightFillet:
        {
            UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:cellBackView.bounds byRoundingCorners:UIRectCornerBottomRight | UIRectCornerTopRight cornerRadii:CGSizeMake(8, 8)];
            CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
            maskLayer.frame = cellBackView.bounds;
            maskLayer.path = maskPath.CGPath;
            cellBackView.layer.mask = maskLayer;
        }
            break;
        case TopLeftFillet:
        {
            UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:cellBackView.bounds byRoundingCorners:UIRectCornerTopLeft cornerRadii:CGSizeMake(8, 8)];
            CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
            maskLayer.frame = cellBackView.bounds;
            maskLayer.path = maskPath.CGPath;
            cellBackView.layer.mask = maskLayer;
        }
            break;
        case TopRightFillet:
        {
            UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:cellBackView.bounds byRoundingCorners:UIRectCornerTopRight cornerRadii:CGSizeMake(8, 8)];
            CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
            maskLayer.frame = cellBackView.bounds;
            maskLayer.path = maskPath.CGPath;
            cellBackView.layer.mask = maskLayer;
        }
            break;
        case BottomLeftFillet:
        {
            UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:cellBackView.bounds byRoundingCorners:UIRectCornerBottomLeft cornerRadii:CGSizeMake(8, 8)];
            CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
            maskLayer.frame = cellBackView.bounds;
            maskLayer.path = maskPath.CGPath;
            cellBackView.layer.mask = maskLayer;
        }
            break;
        case BottomRightFillet:
        {
            UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:cellBackView.bounds byRoundingCorners:UIRectCornerBottomRight cornerRadii:CGSizeMake(8, 8)];
            CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
            maskLayer.frame = cellBackView.bounds;
            maskLayer.path = maskPath.CGPath;
            cellBackView.layer.mask = maskLayer;
        }
            break;
        default:
            break;
    }
    return cellBackView;
}
//+ (void)openTelephonePad
//{
//    NSMutableString * str = [[NSMutableString alloc] initWithFormat:@"telprompt://%@", ServicePhoneNumber];
//    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
//}

@end
