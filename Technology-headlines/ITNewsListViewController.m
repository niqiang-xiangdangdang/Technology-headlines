//
//  ITNewsListViewController.m
//  Technology-headlines
//
//  Created by NIQIANG on 16/6/8.
//  Copyright © 2016年 NIQIANG. All rights reserved.
//

#import "ITNewsListViewController.h"

@interface ITNewsListViewController ()

@end

@implementation ITNewsListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadData];
}

#pragma mark -加载数据

- (void)loadData{

    //URL
    NSString *urlString = @"http://news.coolban.com/Api/Index/news_list/app/2/cat/0/limit/20/time/1464881444/type/0?channel=appstore&uuid=204ACEB6-9827-4AC7-A107-7CE2E48B0897&net=5&model=iPhone&ver=1.0.5";
    
    NSURL *url = [NSURL URLWithString:urlString];
    
    //网络请求
    [[[NSURLSession sharedSession] dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error != nil) {
            NSLog(@"请求错误！%@",error);
            return ;
        }
        
        //json 解析
        NSArray *array = [NSJSONSerialization JSONObjectWithData:data options:0 error:NULL];
        
        NSLog(@"%@",array);
    }]resume];
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
