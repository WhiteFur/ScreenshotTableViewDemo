//
//  MyTableViewCell.h
//  TextViewCell
//
//  Created by Lin Cheng Kai on 14/1/9.
//  Copyright (c) 2014年 Lin Cheng Kai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet UIButton *button;
@property (weak, nonatomic) IBOutlet UITextField *textField;

@end
