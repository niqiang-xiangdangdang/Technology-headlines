//
//  ITNewsCell.m
//  Technology-headlines
//
//  Created by NIQIANG on 16/6/9.
//  Copyright © 2016年 NIQIANG. All rights reserved.
//

#import "ITNewsCell.h"
#import <UIImageView+WebCache.h>

@interface ITNewsCell()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *summaryLabel;
@property (weak, nonatomic) IBOutlet UILabel *siteLabel;
@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imageWidthCons;


@end
@implementation ITNewsCell

- (void)setModel:(ITNews *)model{
    _model = model;
    
    _titleLabel.text = model.title;
    _summaryLabel.text = model.summary;
    _siteLabel.text = model.sitename;
    _timeLabel.text = model.docDate;
    
    
//    NSURL *url = [NSURL URLWithString:model.src_img];
//    [_iconView sd_setImageWithURL:url];
    if (model.src_img.length > 0) {
        NSURL *url = [NSURL URLWithString:model.src_img];
        [_iconView sd_setImageWithURL:url];
        
        _imageWidthCons.constant = 80;

    } else {
        _imageWidthCons.constant = 0;
    }
    
    
    [self layoutIfNeeded];
    
    BOOL hideSummary = CGRectGetMaxY(_summaryLabel.frame) > CGRectGetMinY(_siteLabel.frame);
    
    _summaryLabel.hidden = hideSummary;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
