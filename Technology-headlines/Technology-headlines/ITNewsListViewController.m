//
//  ITNewsListViewController.m
//  Technology-headlines
//
//  Created by NIQIANG on 16/6/8.
//  Copyright © 2016年 NIQIANG. All rights reserved.
//

#import "ITNewsListViewController.h"
#import "ITNews.h"
#import "ITPullupView.h"
#import "ITNewsCell.h"

static NSString *cellId = @"cellId";

@interface ITNewsListViewController ()
@property (nonatomic, strong) NSMutableArray <ITNews *> *newsList;
//上拉刷新视图
@property (nonatomic, weak) ITPullupView *pullipView;

@end

@implementation ITNewsListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //设置表格行高
    self.tableView.rowHeight = 110;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    //注册原型cell
    [self.tableView registerNib:[UINib nibWithNibName:@"ITNewsCell" bundle:nil] forCellReuseIdentifier:cellId];
    
//    self.tableView.tableFooterView = [ITPullupView pullupView];
    ITPullupView *pullup = [ITPullupView pullupView];
   
    self.tableView.tableFooterView = pullup;
    _pullipView = pullup;
    
    [self loadData];
}

#pragma mark -刷新

//- (void)loadData{
- (IBAction)loadData{
    NSLog(@"开始刷新");
   
    NSString *timeStr;
    
    BOOL isPullup = _pullipView.indicator.isAnimating;
    
    if (isPullup) {
        NSLog(@"开始上拉刷新");
        timeStr = _newsList.lastObject.addtime;
    } else {
       NSLog(@"开始下拉刷新");
        timeStr = [self timeString];
    }
    
     //URL
    NSString *urlString = [NSString stringWithFormat:@"http://news.coolban.com/Api/Index/news_list/app/2/cat/0/limit/20/time/%@/type/%d?channel=appstore&uuid=204ACEB6-9827-4AC7-A107-7CE2E48B0897&net=5&model=iPhone&ver=1.0.5",timeStr,isPullup];
    
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
        
//        self.newsList = arrayM;
        if (isPullup) {
            [self.newsList addObjectsFromArray:arrayM];
        } else {
            self.newsList = arrayM ;
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            NSLog(@"结束刷新");
            
            //关闭刷新控件
            [self.refreshControl endRefreshing];
            
            //关闭上拉刷新动画
            [self.pullipView.indicator stopAnimating];
            
            [self.tableView reloadData];
        });
    }]resume];
}

#pragma mark -获取时间
- (NSString *)timeString {
    NSDate *date = [NSDate date];
    
    NSInteger dalte = [date timeIntervalSince1970];
    
    return @(dalte).description;
}

#pragma mark -UITableViewDelegate

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{

    if ((indexPath.row == [tableView numberOfRowsInSection:0] - 1) && !_pullipView.indicator.isAnimating) {
        NSLog(@"最后一行，刷新");
        
        [_pullipView.indicator startAnimating];
   
        [self loadData];
    }
}

#pragma mark -UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _newsList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ITNewsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellId" forIndexPath:indexPath];
    
//    cell.textLabel.text = _newsList[indexPath.row].title;
    cell.model = _newsList[indexPath.row];
    
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
