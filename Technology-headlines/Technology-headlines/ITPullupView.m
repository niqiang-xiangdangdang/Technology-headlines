//
//  ITPullupView.m
//  Technology-headlines
//
//  Created by NIQIANG on 16/6/9.
//  Copyright © 2016年 NIQIANG. All rights reserved.
//

#import "ITPullupView.h"

@implementation ITPullupView

+ (instancetype)pullupView{

    UINib *nib = [UINib nibWithNibName:@"ITPullupView" bundle:nil];
    
    return [nib instantiateWithOwner:nil options:nil].lastObject;

}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
