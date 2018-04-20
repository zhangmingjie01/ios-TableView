//
//  ListViewController.m
//  UItableview
//
//  Created by apple on 2018/1/4.
//  Copyright © 2018年 listview. All rights reserved.
//

#import "ListViewController.h"

@interface ListViewController ()

@end

@implementation ListViewController

@synthesize stuArray = _stuArray;
@synthesize teaArray = _teaArray;
@synthesize teaCell = _teaCell;

- (void)viewDidLoad
{
    //初始化学生数据(class,name,stuNumber,image)
    NSDictionary *dic1 = [[NSDictionary alloc]initWithObjectsAndKeys:@"一班",@"class",@"李秋",@"name",@"200931000919",@"stuNumber",@"1.jpg",@"image",nil];
    NSDictionary *dic2 = [[NSDictionary alloc]initWithObjectsAndKeys:@"二班",@"class",@"张亮",@"name",@"200931000920",@"stuNumber",@"2.jpg",@"image",nil];
    NSDictionary *dic3 = [[NSDictionary alloc]initWithObjectsAndKeys:@"三班",@"class",@"杨光",@"name",@"200931000921",@"stuNumber",@"3.jpg",@"image",nil];
    NSDictionary *dic4 = [[NSDictionary alloc]initWithObjectsAndKeys:@"四班",@"class",@"atany",@"name",@"200931000922",@"stuNumber",@"4.jpg",@"image",nil];
    
    _stuArray = [[NSArray alloc]initWithObjects:dic1, dic2, dic3, dic4, nil];
    
    
    
    //初始化老师数据
    NSDictionary *tDic1 = [[NSDictionary alloc]initWithObjectsAndKeys:@"史小强",@"name",@"讲师",@"type", @"C406", @"office",nil];
    NSDictionary *tDic2 = [[NSDictionary alloc]initWithObjectsAndKeys:@"李永乐",@"name",@"教授",@"type", @"D011", @"office",nil];
    
    _teaArray = [[NSArray alloc]initWithObjects:tDic1,tDic2, nil];
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//每个分区的行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return section == 1?[_stuArray count]:2;
    
}

//表的分区数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

//定义分区的标题
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return section == 1?@"学生信息":@"老师信息";
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell;
    if([indexPath section] == 1){
        //通过代码自定义cell
        cell = [self customCellWithOutXib:tableView withIndexPath:indexPath];
    }
    else{
        //通过nib自定义cell
        cell = [self customCellByXib:tableView withIndexPath:indexPath];
    }
    assert(cell != nil);
    return cell;
}

//修改行高度的位置
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 90;
}

//通过代码自定义cell
-(UITableViewCell *)customCellWithOutXib:(UITableView *)tableView withIndexPath:(NSIndexPath *)indexPath{
    //定义标识符
    static NSString *customCellIndentifier = @"CustomCellIndentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:customCellIndentifier];
    
    //定义新的cell
    if(cell == nil){
        //使用默认的UITableViewCell,但是不使用默认的image与text，改为添加自定义的控件
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:customCellIndentifier];
        //姓名
        CGRect nameRect = CGRectMake(88, 15, 70, 25);
        UILabel *nameLabel = [[UILabel alloc]initWithFrame:nameRect];
        nameLabel.font = [UIFont boldSystemFontOfSize:nameFontSize];
        nameLabel.tag = nameTag;
        nameLabel.textColor = [UIColor brownColor];
        [cell.contentView addSubview:nameLabel];
        
        //班级
        CGRect classTipRect = CGRectMake(88, 40, 40, 14);
        UILabel *classTipLabel = [[UILabel alloc]initWithFrame:classTipRect];
        classTipLabel.text = @"班级:";
        classTipLabel.font = [UIFont boldSystemFontOfSize:fontSize];
        [cell.contentView addSubview:classTipLabel];
        
        
        CGRect classRect = CGRectMake(135, 40, 40, 14);
        UILabel *classLabel = [[UILabel alloc]initWithFrame:classRect];
        classLabel.tag = classTag;
        classLabel.font = [UIFont boldSystemFontOfSize:fontSize];
        [cell.contentView addSubview:classLabel];
        
        //学号
        CGRect stuNameTipRect = CGRectMake(88, 60, 40, 12);
        UILabel *stuNameTipLabel = [[UILabel alloc]initWithFrame:stuNameTipRect];
        stuNameTipLabel.text = @"学号:";
        stuNameTipLabel.font = [UIFont boldSystemFontOfSize:fontSize];
        [cell.contentView addSubview:stuNameTipLabel];
        
        CGRect stuNameRect = CGRectMake(135, 60, 150, 14);
        UILabel *stuNameLabel = [[UILabel alloc]initWithFrame:stuNameRect];
        stuNameLabel.tag = stuNumberTag;
        stuNameLabel.font = [UIFont boldSystemFontOfSize:fontSize];
        
        [cell.contentView addSubview:stuNameLabel];
        
        //图片
        CGRect imageRect = CGRectMake(15, 15, 60, 60);
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:imageRect];
        imageView.tag = imageTag;
        
        //为图片添加边框
        CALayer *layer = [imageView layer];
        layer.cornerRadius = 8;
        layer.borderColor = [[UIColor whiteColor]CGColor];
        layer.borderWidth = 1;
        layer.masksToBounds = YES;
        [cell.contentView addSubview:imageView];
    }
    //获得行数
    NSUInteger row = [indexPath row];
    
    //取得相应行数的数据（NSDictionary类型，包括姓名、班级、学号、图片名称）
    NSDictionary *dic = [_stuArray objectAtIndex:row];
    
    //设置图片
    UIImageView *imageV = (UIImageView *)[cell.contentView viewWithTag:imageTag];
    imageV.image = [UIImage imageNamed:[dic objectForKey:@"image"]];
    
    //设置姓名
    UILabel *name = (UILabel *)[cell.contentView viewWithTag:nameTag];
    name.text = [dic objectForKey:@"name"];
    
    //设置班级
    UILabel *class = (UILabel *)[cell.contentView viewWithTag:classTag];
    class.text = [dic objectForKey:@"class"];
    
    //设置学号
    UILabel *stuNumber = (UILabel *)[cell.contentView viewWithTag:stuNumberTag];
    stuNumber.text = [dic objectForKey:@"stuNumber"];
    
    //设置右侧箭头
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

//通过nib文件自定义cell
-(UITableViewCell *)customCellByXib:(UITableView *)tableView withIndexPath:(NSIndexPath *)indexPath{
    static NSString *customXibCellIdentifier = @"CustomXibCellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:customXibCellIdentifier];
    if(cell == nil){
        NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"CustomCell" owner:self options:nil];//加载nib文件
        if([nib count]>0){
            cell = _teaCell;
        }
        else{
            (NO);//读取文件失败
        }
    }
    NSUInteger row = [indexPath row];
    NSDictionary *dic  = [_teaArray objectAtIndex:row];
    //姓名
    ((UILabel *)[cell.contentView viewWithTag:teaNameTag]).text = [dic objectForKey:@"name"];
    
    //类型
    ((UILabel *)[cell.contentView viewWithTag:teaTypeTag]).text = [dic objectForKey:@"type"];
    
    //办公室
    ((UILabel *)[cell.contentView viewWithTag:teaOfficeTag]).text = [dic objectForKey:@"office"];
    return cell;
}



- (void)dealloc {
//    [_teaCell release];
//    [super dealloc];
}
@end

