//
//  ListViewController.h
//  UItableview
//
//  Created by apple on 2018/1/4.
//  Copyright © 2018年 listview. All rights reserved.
//

#import <UIKit/UIKit.h>

//学生
#define nameTag          1
#define classTag         2
#define stuNumberTag     3
#define imageTag         4
#define nameFontSize    15
#define fontSize        12

//老师
#define teaNameTag       1
#define teaTypeTag       2
#define teaOfficeTag     3

@interface ListViewController : UIViewController <UITableViewDelegate,UITableViewDataSource>

@property (retain,nonatomic) NSArray *stuArray;//学生资料
@property (retain,nonatomic) NSArray *teaArray;//老师资料
@property (retain, nonatomic) IBOutlet UITableViewCell *teaCell;

@end
