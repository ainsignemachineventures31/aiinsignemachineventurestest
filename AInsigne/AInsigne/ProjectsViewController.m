//
//  ProjectsViewController.m
//  AInsigne
//
//  Created by macbook on 4/15/16.
//  Copyright © 2016 Machine-Ventures. All rights reserved.
//

#import "ProjectsViewController.h"

@interface ProjectsViewController ()

@end

@implementation ProjectsViewController

FireBaseHandler *projfbh;
NSMutableArray *projectDetected;
NSString *projectSelected;
int currentproj = 0;
BOOL selected = NO;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    [self initFBH];
    [self disableAll];
    [self detectUser];
    [self detectProjects];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)disableAll
{
    [self disableButton:_createBtn disable:YES];
    [self disableButton:_updateBtn disable:YES];
    [self disableButton:_deleteBtn disable:YES];
}

- (void)disableButton:(UIButton *)btn disable:(BOOL)disable
{
    [btn setEnabled:!disable];
}

- (void)detectUser
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 4 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        if([projfbh getDetectedUser]!=nil)
        {
            [projfbh setProject:_userName];
            [projfbh detectProjects:_userName];
        }
    });
    
}

- (void)updateProjects
{
    [self disableAll];
    currentproj = 0;
    [projfbh detectProjects:_userName];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 4 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        [self projectReady];
    });
}


- (void)projectReady
{
    if([projfbh getDetectedProjects]!=nil && [[projfbh getDetectedProjects] count] > 0)
    {
        projectDetected = [projfbh getDetectedProjects];
        
        [self changeView];
        [self selectProject];
        [self disableButton:_createBtn disable:NO];
        [self disableButton:_updateBtn disable:NO];
        [self disableButton:_deleteBtn disable:YES];
    }
    else
        [self disableButton:_createBtn disable:NO];
}

- (void)detectProjects
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 8 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        [self projectReady];
    });
}

- (void)removeSubview
{
    for (UIView *subView in _uiView.subviews)
    {
            [subView removeFromSuperview];
    }
}

- (void)changeView
{
    int y = 0;
    [self removeSubview];
   
    if([projectDetected[0] isKindOfClass:[NSDictionary class]])
    {
        NSArray *arrProj = [(NSDictionary *)projectDetected[0] allKeys];
        
        if(currentproj >= 0 && currentproj < [arrProj count])
        {
            
            UILabel *lblProjName = [[UILabel alloc]init];
            UILabel *lblProjDesc = [[UILabel alloc]init];
            UILabel *lblProjDuration = [[UILabel alloc]init];
            UILabel *lblProjTech = [[UILabel alloc]init];
            if([[(NSDictionary *)projectDetected[0] objectForKey:arrProj[currentproj]]  isKindOfClass:[NSDictionary class]])
            {
                NSDictionary *dictProjDetails = [(NSDictionary *)projectDetected[0] objectForKey:arrProj[currentproj]];
                
                if([[dictProjDetails allKeys] count]>1)
                {
                    lblProjName.text = [dictProjDetails objectForKey:@"proj_name"];
                    lblProjDesc.text = [dictProjDetails objectForKey:@"description"];
                    lblProjDuration.text = [dictProjDetails objectForKey:@"duration"];
                    lblProjTech.text = [dictProjDetails objectForKey:@"programming_language_and_tech_used"];
                    [lblProjName setFrame:CGRectMake(0, y, 225,30)];
                    y = y + 33;
                    [lblProjDesc setFrame:CGRectMake(0, y, 225,30)];
                    y = y + 33;
                    [lblProjDuration setFrame:CGRectMake(0, y, 225,30)];
                    y = y + 33;
                    [lblProjTech setFrame:CGRectMake(0, y, 225,30)];
                    y = y + 33;
                       CGRect cgrv = CGRectMake(0, 0, _uiView.frame.size.width,_uiView.frame.size.height);
                    [_uiView setFrame: cgrv];
                    [_uiView setBackgroundColor:[UIColor whiteColor]];
                    [_uiView addSubview:lblProjName];
                    [_uiView addSubview:lblProjDesc];
                    [_uiView addSubview:lblProjDuration];
                    [_uiView addSubview:lblProjTech];
                    [self addTap:_uiView];
                }
            }
        }
    }
}


- (void)addTap:(UIView* )uv
{
    UITapGestureRecognizer *singleFingerTap =
    [[UITapGestureRecognizer alloc] initWithTarget:self
                                            action:@selector(selectProject)];
    [uv addGestureRecognizer:singleFingerTap];
}

- (void)selectProject
{
    if([projectDetected[0] isKindOfClass:[NSDictionary class]])
    {
        selected = YES;
        [_uiView setBackgroundColor:[UIColor lightGrayColor]];
        NSArray *arrProj = [(NSDictionary *)projectDetected[0] allKeys];

            if([[(NSDictionary *)projectDetected[0] objectForKey:arrProj[currentproj]]  isKindOfClass:[NSDictionary class]])
            {
                NSDictionary *dictProjDetails = [(NSDictionary *)projectDetected[0] objectForKey:arrProj[currentproj]];

                    _projName.text= [dictProjDetails objectForKey:@"proj_name"];
                    _projDesc.text = [dictProjDetails objectForKey:@"description"];
                    _projDuration.text = [dictProjDetails objectForKey:@"duration"];
                    _projTech.text = [dictProjDetails objectForKey:@"programming_language_and_tech_used"];
                    projectSelected = _projName.text;
                    [self disableButton:_deleteBtn disable:NO];
                    [self disableButton:_updateBtn disable:NO];
                
            }
        
    }
}



- (void)initFBH
{
    projfbh = [[FireBaseHandler alloc]init];
    [projfbh initFBHandler];
    [projfbh detectUser:_userName];
}


- (IBAction)createProj:(id)sender {

        [projfbh addProjects:_projName.text projectDesc:_projDesc.text projectDuration:_projDuration.text  projLanguage:_projTech.text];
        [self updateProjects];
}

- (IBAction)updateProj:(id)sender {
    if(selected == YES && projectSelected!=nil)
    {
        [projfbh updateProjects:_projName.text projectDesc:_projDesc.text projectDuration:_projDuration.text  projLanguage:_projTech.text];
        [self updateProjects];
    }
}
- (IBAction)deleteProj:(id)sender {
    if(projectSelected!=nil && selected == YES)
    {
        [projfbh deleteProject:projectSelected];
        [self updateProjects];
    }
}

- (IBAction)goBack:(id)sender {
    UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main"                        bundle:nil];
    CrudViewController *cv = [storyboard instantiateViewControllerWithIdentifier:@"crudview"];
    cv.userName = _userName;
    [self presentViewController:cv animated:NO completion:nil];
}
- (IBAction)btnPrev:(id)sender {
    selected = NO;
    [self disableButton:_deleteBtn disable:YES];
    [self disableButton:_updateBtn disable:YES];
    if([projectDetected[0] isKindOfClass:[NSDictionary class]])
    {

        if(currentproj > 0)
           currentproj--;
    }
    [self changeView];
}

- (IBAction)btnNext:(id)sender {
    selected = NO;
    [self disableButton:_deleteBtn disable:YES];
    [self disableButton:_updateBtn disable:YES];
    if([projectDetected[0] isKindOfClass:[NSDictionary class]])
    {
        NSArray *arrProj = [(NSDictionary *)projectDetected[0] allKeys];
        if(currentproj < [arrProj count] - 1)
            currentproj++;
    }

    [self changeView];
}
@end
