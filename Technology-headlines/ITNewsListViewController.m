//
//  ITNewsListViewController.m
//  Technology-headlines
//
//  Created by NIQIANG on 16/6/8.
//  Copyright © 2016年 NIQIANG. All rights reserved.
//

#import "ITNewsListViewController.h"
#import "ITNews.h"

@interface ITNewsListViewController ()
@property (nonatomic, strong) NSMutableArray <ITNews *> *newsList;
@end

@implementation ITNewsListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadData];
}

#pragma mark -加载数据

//- (void)loadData{
- (IBAction)loadData{
    NSLog(@"开始刷新");
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
        
//        NSLog(@"%@",array);
        NSMutableArray *arrayM = [NSMutableArray array];
        
        for (NSDictionary *dict in array) {
            
            ITNews *model = [ITNews new];
            
            [model setValuesForKeysWithDictionary:dict];
            
            [arrayM addObject:model];
        }
        
//        NSLog(@"%@",arrayM);
        
        self.newsList = arrayM;
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            NSLog(@"结束刷新");
            
            [self.refreshControl endRefreshing];
            
            [self.tableView reloadData];
        });
    }]resume];
}

#pragma mark -UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _newsList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellId" forIndexPath:indexPath];
    
    cell.textLabel.text = _newsList[indexPath.row].title;
    return cell;
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
