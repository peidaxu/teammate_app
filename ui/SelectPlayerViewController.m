//
//  ViewController.m
//  testtableselect
//
//  Created by teammate on 13/10/3.
//  Copyright (c) 2013年 teammate. All rights reserved.
//

#import "SelectPlayerViewController.h"


@interface SelectPlayerViewController ()



@end

@implementation SelectPlayerViewController
@synthesize nowquarter;
@synthesize quartercount;
@synthesize quarterlong;
@synthesize oppname;

//variable
@synthesize myteamscoer;
@synthesize oppteamscore;
@synthesize quarternow;
@synthesize lasttime;


- (void)viewDidLoad
{
    checkpeople=0;
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    player=[[NSMutableArray alloc]init];
    
    //這裡要寫要怎麼找到球員
    player=[NSMutableArray arrayWithObjects:@"Jason",@"Terry",@"Star",@"Ike",@"George",@"Lin",@"Ding",nil];
    playerphoto=[NSMutableArray arrayWithObjects:@"Jason.jpg",@"Terry.jpg",@"Star.jpg",@"Ike.jpg",@"George.jpg",@"Lin.jpg",@"Ding.jpg", nil];
    playerposition=[NSMutableArray arrayWithObjects:@"PF",@"PG",@"SF",@"C",@"SG",@"SG",@"c",nil];
    playernumber=[NSMutableArray arrayWithObjects:@"8",@"21",@"15",@"0",@"24",@"7",@"23", nil];
    
    playerselected=[[NSMutableArray alloc]init];
    UITableView *allplayers=[[UITableView alloc]initWithFrame:CGRectMake(0, 60, self.view.frame.size.width, self.view.frame.size.height-200)];
    self.title=@"選擇上場球員";
    allplayers.delegate=self;
    allplayers.dataSource=self;
    [self.view addSubview:allplayers];
    
    
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return player.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *cellideng =@"cell";
    PlayerCell *cell =[tableView dequeueReusableCellWithIdentifier:cellideng];
    
    if (cell==nil) {
        NSArray *nib=[[NSBundle mainBundle]loadNibNamed:@"playercell" owner:self options:nil];
        cell =[nib objectAtIndex:0];
        
    }
    cell.nameLabel.text=[player objectAtIndex:indexPath.row];
    cell.Playerposition.text=[playerposition objectAtIndex:indexPath.row];
    cell.Playerphoto.image=[UIImage imageNamed:[playerphoto objectAtIndex:indexPath.row]];
    cell.backgroundColor=[UIColor redColor];
   // NSLog(@"%d",indexPath.row);
    //NSLog(@"count=%d",playerselected.count);
    for (int i=0; i<playerselected.count; i++) {
        int a=[[playerselected objectAtIndex:i]intValue];
        if (indexPath.row==a) {
            cell.accessoryType=UITableViewCellAccessoryCheckmark;
        }
    }
    return cell;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
   
    UITableViewCell *cell=[tableView cellForRowAtIndexPath:indexPath];
       
    //if cell is not check,
    //NSLog(@"indexPath: %i", indexPath.row);
    if (cell.accessoryType == UITableViewCellAccessoryNone && checkpeople<5){
        checkpeople++;
        NSLog(@"%d",checkpeople);
        
        cell.accessoryType =UITableViewCellAccessoryCheckmark;
        [playerselected addObject:[NSNumber numberWithInt:indexPath.row]];
       
    }//else cell is check,
    else if (checkpeople==5 && cell.accessoryType==UITableViewCellAccessoryNone)
    {
        UIAlertView *alertpeoplefull =[[UIAlertView alloc]initWithTitle:@"Alert!" message:@"人數已達上線" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alertpeoplefull show];
    }
    else
    {
    
        checkpeople--;
        NSLog(@"%d",checkpeople);
        cell.accessoryType =UITableViewCellAccessoryNone;
        [playerselected removeObject:[NSNumber numberWithInt:indexPath.row]];
    }
    //NSLog(@"playerselected=%@",playerselected);
    
    [tableView selectRowAtIndexPath:indexPath
                           animated:YES
                     scrollPosition:UITableViewScrollPositionMiddle];
   
    
    //[tableView reload]
}





-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 78;
}

- (IBAction)gotorecordpage:(id)sender {
    //NSLog(@"%@",player[[playerselected[0]intValue]]);
    if (checkpeople != 5) {
        UIAlertView *alertpeopleless=[[UIAlertView alloc]initWithTitle:@"人數不足" message:@"請確定有選好五位先發球員" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alertpeopleless show];
    }
    else{
        recordViewController *record=[self.storyboard instantiateViewControllerWithIdentifier:@"recordview"];
    
        record.awayname =oppname;
        record.quartercount =quartercount;
        record.quarterlong =quarterlong;
    
    
        record.playerphoto=[NSMutableArray arrayWithObjects:playerphoto[[playerselected[0]intValue]],playerphoto[[playerselected[1]intValue]],playerphoto[[playerselected[2]intValue]],playerphoto[[playerselected[3]intValue]],playerphoto[[playerselected[4]intValue]],nil];
        record.playername=[NSMutableArray arrayWithObjects:player[[playerselected[0]intValue]],player[[playerselected[1]intValue]],player[[playerselected[2]intValue]],player[[playerselected[3]intValue]],player[[playerselected[4]intValue]], nil];
        record.playernumber=[NSMutableArray arrayWithObjects:playernumber[[playerselected[0]intValue]],playernumber[[playerselected[1]intValue]],playernumber[[playerselected[2]intValue]],playernumber[[playerselected[3]intValue]],playernumber[[playerselected[4]intValue]], nil];
        
        record.opteamscore.text=[NSString stringWithFormat:@"%d",oppteamscore];
        
        record.awayname=oppname;
        //NSLog(@"This is record oppname:%@",record.awayname);
        //NSLog(@"This is selectview opname: %@",oppname);
        
        record.myscore=myteamscoer;
        record.oppscore=oppteamscore;
        //record.myteamscore.text=[NSString stringWithFormat:@"%d",myteamscoer];
        //record.opteamscore.text=[NSString stringWithFormat:@"%d",oppteamscore];
        record.quarternow=quarternow;
        record.nowquarter.text=[NSString stringWithFormat:@"%@",nowquarter];
        record.lastTime=lasttime;
        
        
    [self presentViewController:record animated:YES completion:nil];
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
        
    }
}
@end