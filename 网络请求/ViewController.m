//
//  ViewController.m
//  网络请求
//
//  Created by apple on 15/8/20.
//  Copyright (c) 2015年 Tomikes. All rights reserved.
//
#define kVideoURL @""
#import "ViewController.h"

@interface ViewController () <NSURLConnectionDataDelegate>
@property (strong, nonatomic) UIImageView *imageView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //url
//    NSString *ss = @"http://www.baidu.com";
//    NSString *str = [NSString stringWithFormat:@"%@?query=%@®ion=%@&output=json&ak=6E823f587c95f0148c19993539b99295", ss, @"银行", @"济南"];
    NSString *str = [NSString stringWithFormat:@"http://image.zcool.com.cn/56/13/1308200901454.jpg"];
    NSString *news = [str stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *url = [NSURL URLWithString:news];
    //req
    NSURLRequest *req = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:10];
    NSURLResponse *resp = nil;
    NSError *err =nil;
    //同步函数
     NSData *data = [NSURLConnection sendSynchronousRequest:req returningResponse:&resp error:&err];
    //NSJSONReadingMutableContainers返回的事可辨数组或字典，option选0返回的是nsarray活着nsdic
     NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    
    
    
    //异步函数，在块里面赋值
   [NSURLConnection sendAsynchronousRequest:req queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError){
        self.imageView.image = [UIImage imageWithData:data];
        // 解析
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"%@", dic);
    }];
    
   
}
- (IBAction)mybutton:(id)sender {
    
    // 1.根据网址初始化OC字符串对象
    NSString *urlStr = [NSString stringWithFormat:@"%@", kVideoURL];
    // 2.创建NSURL对象
    NSURL *url = [NSURL URLWithString:urlStr];
    // 3.创建请求
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    // 4.创建参数字符串对象
    NSString *parmStr = @"method=album.channel.get&appKey=myKey&format=json&channel=t&pageNo=1&pageSize=10";
    // 5.将字符串转为NSData对象
    NSData *pramData = [parmStr dataUsingEncoding:NSUTF8StringEncoding];
    // 6.设置请求体
    [request setHTTPBody:pramData];
    // 7.设置请求方式
    [request setHTTPMethod:@"POST"];
    
    // 创建同步链接
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];

}
- (IBAction)oneb:(id)sender {
    
    // 异步POST请求
    NSString *urlString = [NSString stringWithFormat:@"%@",kVideoURL];
    //创建url对象
    NSURL *url = [NSURL URLWithString:urlString];
    //创建请求
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:10];
    //创建参数字符串对象
    NSString *parmStr = [NSString stringWithFormat:@"method=album.channel.get&appKey=myKey&format=json&channel=t&pageNo=1&pageSize=10"];
    //将字符串转换为NSData对象
    NSData *data = [parmStr dataUsingEncoding:NSUTF8StringEncoding];
    [request setHTTPBody:data];
    [request setHTTPMethod:@"POST"];
    //创建异步连接（形式二）
    [NSURLConnection connectionWithRequest:request delegate:self];
}

//异步请求的四个方法

// 服务器接收到请求时
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
}
// 当收到服务器返回的数据时触发, 返回的可能是资源片段
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
}
// 当服务器返回所有数据时触发, 数据返回完毕
- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
}
// 请求数据失败时触发
- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    NSLog(@"%s", __FUNCTION__);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
