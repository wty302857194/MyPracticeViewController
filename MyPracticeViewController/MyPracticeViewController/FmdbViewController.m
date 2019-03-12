//
//  FmdbViewController.m
//  MyPracticeViewController
//
//  Created by wbb on 2017/7/28.
//  Copyright © 2017年 cjh. All rights reserved.
//

#import "FmdbViewController.h"
#import "FMDB.h"
#import <QuickLook/QuickLook.h> 
#import "TYYinDaoYeView.h"

@interface FmdbViewController ()<UIWebViewDelegate,UIScrollViewDelegate,UIDocumentInteractionControllerDelegate,QLPreviewControllerDataSource>

@property (weak, nonatomic) IBOutlet UITextField *yaLiTF;
@property (weak, nonatomic) IBOutlet UITextField *wenDuTF;
@property(nonatomic,retain)UIDocumentInteractionController *docController;
@property(nonatomic,retain) UIWebView *webView;
@end

@implementation FmdbViewController
- (UIWebView *)webView {
    if (!_webView) {
        _webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREENH_HEIGHT)];
        _webView.delegate = self;
        [self.view addSubview:_webView];
    }
    return _webView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
//    [self QLPreviewControllerRequest];
    [self fmdbData];
    
    
    [self yinDaoYe];
}
- (void)yinDaoYe {
    NSArray *imgarr = @[[UIImage imageNamed:@"intro1"],[UIImage imageNamed:@"intro2"]];
    
    TYYinDaoYeView * yindaoye = [[TYYinDaoYeView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREENH_HEIGHT) imagesArr:imgarr];
    [self.view addSubview:yindaoye];
}
- (void)QLPreviewControllerRequest {
    QLPreviewController *qlPC = [[QLPreviewController alloc]init];
    //设置代理
    qlPC.dataSource = self;
    
    [self presentViewController:qlPC animated:YES completion:nil];
}
- (void)fmdbData {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSError *error;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
    NSString *documentsDirectory  = paths[0];
    NSString *dbPath =[documentsDirectory stringByAppendingPathComponent:@"NewYMY.db"];
    NSLog(@"%@",dbPath);
    //    if([fileManager fileExistsAtPath:dbPath]== NO){
    //        NSString *resourcePath = [[NSBundle mainBundle] pathForResource:@"NewYMY" ofType:@"db"];
    //        [fileManager copyItemAtPath:resourcePath toPath:dbPath error:&error];
    //
    //    } else {
    //        NSDictionary *pathDic = [NSDictionary dictionaryWithContentsOfFile:dbPath];
    //        NSLog(@"%@",pathDic);
    //    }
    
    FMDatabase* database = [FMDatabase databaseWithPath:dbPath];
    if ( ![database open] )
    {
        return;
    }
    // 查找表 AllTheQustions
    FMResultSet* resultSet = [database executeQuery: @"select * from R11" ];
    
    // 逐行读取数据
    while ([resultSet next])
    {
        // 对应字段来取数据
        NSString* psi = [ resultSet stringForColumn: @"psi"];
        NSString* dew = [ resultSet stringForColumn: @"dew"];
        NSLog( @"psi: %@ , question: %@" , psi , dew );
    }
    
    [ database close ];
}
- (void)createXLSFile {
    // 创建存放XLS文件数据的数组
    NSMutableArray  *xlsDataMuArr = [[NSMutableArray alloc] init];
    // 第一行内容
    [xlsDataMuArr addObject:@"Time"];
    [xlsDataMuArr addObject:@"Address"];
    [xlsDataMuArr addObject:@"Person"];
    [xlsDataMuArr addObject:@"Reason"];
    [xlsDataMuArr addObject:@"Process"];
    [xlsDataMuArr addObject:@"Result"];
    // 100行数据
    for (int i = 0; i < 100; i ++) {
        [xlsDataMuArr addObject:@"2016-12-06 17:18:40"];
        [xlsDataMuArr addObject:@"GuangZhou"];
        [xlsDataMuArr addObject:@"Mr.Liu"];
        [xlsDataMuArr addObject:@"Buy"];
        [xlsDataMuArr addObject:@"TaoBao"];
        [xlsDataMuArr addObject:@"Debt"];
    }
    // 把数组拼接成字符串，连接符是 \t（功能同键盘上的tab键）
    NSString *fileContent = [xlsDataMuArr componentsJoinedByString:@"\t"];
    // 字符串转换为可变字符串，方便改变某些字符
    NSMutableString *muStr = [fileContent mutableCopy];
    // 新建一个可变数组，存储每行最后一个\t的下标（以便改为\n）
    NSMutableArray *subMuArr = [NSMutableArray array];
    for (int i = 0; i < muStr.length; i ++) {
        NSRange range = [muStr rangeOfString:@"\t" options:NSBackwardsSearch range:NSMakeRange(i, 1)];
        if (range.length == 1) {
            [subMuArr addObject:@(range.location)];
        }
    }
    // 替换末尾\t
    for (NSUInteger i = 0; i < subMuArr.count; i ++) {
#warning  下面的6是列数，根据需求修改
        if ( i > 0 && (i%6 == 0) ) {
            [muStr replaceCharactersInRange:NSMakeRange([[subMuArr objectAtIndex:i-1] intValue], 1) withString:@"\n"];
        }
    }
    // 文件管理器
    NSFileManager *fileManager = [[NSFileManager alloc]init];
    //使用UTF16才能显示汉字；如果显示为#######是因为格子宽度不够，拉开即可
    NSData *fileData = [muStr dataUsingEncoding:NSUTF16StringEncoding];
    // 文件路径
//    NSString *path = NSHomeDirectory();
//    NSString *filePath = [path stringByAppendingPathComponent:@"/Documents/export.xls"];
//    NSLog(@"文件路径：\n%@",filePath);
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
    NSString *documentsDirectory  = paths[0];
    NSString *dbPath =[documentsDirectory stringByAppendingPathComponent:@"export.xls"];
    NSLog(@"%@",dbPath);
    // 生成xls文件
    [fileManager createFileAtPath:dbPath contents:fileData attributes:nil];
    
//    NSString *path = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"周工作计划进度表-2017.7月-吴棒棒.xls"];
    NSURL *url = [NSURL fileURLWithPath:dbPath];
    
    [self.webView loadRequest:[NSURLRequest requestWithURL:url]];
    
}
- (void)DocumentInteraction {
    NSString *path = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"周工作计划进度表-2017.7月-吴棒棒.xls"];
    NSURL *url = [NSURL fileURLWithPath:path];
    
    _docController = [UIDocumentInteractionController interactionControllerWithURL:url];
    _docController.delegate = self;
    _docController.UTI = @"com.microsoft.excel.xls";
    [_docController presentPreviewAnimated:YES];

}
- (IBAction)choose:(UIButton *)sender {
}
- (UIViewController *)documentInteractionControllerViewControllerForPreview:(UIDocumentInteractionController *)controller
{
    return self;
}
- (UIView *)documentInteractionControllerViewForPreview:(UIDocumentInteractionController *)controller
{
    return self.view;
}

- (CGRect)documentInteractionControllerRectForPreview:(UIDocumentInteractionController *)controller
{
    return  self.view.frame;
    
}
#pragma mark -- datasource协议方法
- (NSInteger)numberOfPreviewItemsInPreviewController:(QLPreviewController *)controller{
    
    return 1;
}

- (id <QLPreviewItem>)previewController:(QLPreviewController *)controller previewItemAtIndex:(NSInteger)index{
    
    //读取沙盒中的文件
//    NSString *docStr = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)firstObject];
//    NSString *pStr = [docStr stringByAppendingPathComponent:@"abc.docx"];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
    NSString *documentsDirectory  = paths[0];
    NSString *dbPath =[documentsDirectory stringByAppendingPathComponent:@"export.xls"];
    return [NSURL fileURLWithPath:dbPath];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
