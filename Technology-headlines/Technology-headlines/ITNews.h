//
//  ITNews.h
//  Technology-headlines
//
//  Created by NIQIANG on 16/6/8.
//  Copyright © 2016年 NIQIANG. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ITNews : NSObject

// id
@property (nonatomic, copy) NSString *id;
///标题
@property (nonatomic, copy) NSString *title;
// 简介
@property (nonatomic, copy) NSString *summary;
// 图像
@property (nonatomic, copy) NSString *src_img;
// 添加时间
@property (nonatomic, copy) NSString *addtime;
// 来源网站
@property (nonatomic, copy) NSString *sitename;

@end
