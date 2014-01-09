//
//  MyTableViewController.m
//  TextViewCell
//
//  Created by Lin Cheng Kai on 14/1/9.
//  Copyright (c) 2014年 Lin Cheng Kai. All rights reserved.
//

#import "MyTableViewController.h"
#import "MyTableViewCell.h"
#import <QuartzCore/QuartzCore.h>

@interface MyTableViewController ()
- (UIImage*)screenShotForIndexPaths:(NSArray*)indexPaths;

@end

@implementation MyTableViewController

- (UIImage*)screenShotForIndexPaths:(NSArray*)indexPaths
{
    CGPoint originalOffset = self.tableView.contentOffset;
    
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(CGRectGetWidth(self.tableView.frame), self.tableView.rowHeight * [indexPaths count]), NO, 0.0);
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    //---一個一個把cell render到CGContext上
    MyTableViewCell *cell = nil;
    for(NSIndexPath *indexPath in indexPaths)
    {
        //讓該cell被正確的產生在tableView上, 之後才能在CGContext上正確的render出來
        [self.tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionNone animated:NO];
        
        cell = (MyTableViewCell*)[self.tableView cellForRowAtIndexPath:indexPath];
        [cell.layer renderInContext:ctx];
        
        //--欲在context上render的origin
        CGContextTranslateCTM(ctx, 0, self.tableView.rowHeight);
        //--
    }
    //---
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();

    self.tableView.contentOffset = originalOffset;
    
    return image;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if(self = [super initWithCoder:aDecoder])
        self.strs = @[@"abc", @"def", @"ghi", @"jkl", @"mno", @"pqr", @"stu"];
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.navigationItem.rightBarButtonItem.target = self;
    self.navigationItem.rightBarButtonItem.action = @selector(screenshotPressed:);
}

- (void)screenshotPressed:(id)sender
{
    NSMutableArray *indexPaths = [NSMutableArray array];
    for(NSUInteger i = 0; i < [self.tableView numberOfRowsInSection:0]; i++)
    {
        [indexPaths addObject:[NSIndexPath indexPathForRow:i inSection:0]];
    }
    
    UIImage *image = [self screenShotForIndexPaths:indexPaths];
    
    UIActivityViewController *activityVC = [[UIActivityViewController alloc] initWithActivityItems:@[image] applicationActivities:nil];
    
    [self.navigationController presentViewController:activityVC animated:YES completion:NULL];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [_strs count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    MyTableViewCell *cell = (MyTableViewCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    NSString *text = _strs[indexPath.row];
    
    cell.textView.text = text;
    [cell.button setTitle:text forState:UIControlStateNormal];
    cell.textField.text = text;
    return cell;
}
@end
