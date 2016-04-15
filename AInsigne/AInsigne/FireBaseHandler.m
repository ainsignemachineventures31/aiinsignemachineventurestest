//
//  FireBaseHandler.m
//  AInsigne
//
//  Created by macbook on 4/14/16.
//  Copyright © 2016 Machine-Ventures. All rights reserved.
//

#import "FireBaseHandler.h"

@implementation FireBaseHandler

Firebase *ref;
Firebase *usersRef;
Firebase *projectRef;
Firebase *usernameRef;
NSDictionary *project;
NSDictionary *dictProjects;
NSString *detectedUser;
NSMutableArray *detectedProfile;
NSMutableArray *detectedProjects;
-(void)initFBHandler
{
    ref = [[Firebase alloc] initWithUrl:@"https://flickering-heat-7099.firebaseio.com"];
    usersRef = [ref childByAppendingPath: @"users"];
        detectedProfile = [[NSMutableArray alloc]init];
        detectedProjects = [[NSMutableArray alloc]init];
    
}





-(NSString *)getreplacedString:(NSString *)tobeRep
{
    
    tobeRep = [tobeRep
                stringByReplacingOccurrencesOfString:@"@" withString:@""];
    tobeRep = [tobeRep
                stringByReplacingOccurrencesOfString:@"." withString:@""];
    tobeRep = [tobeRep
               stringByReplacingOccurrencesOfString:@"/" withString:@""];
    tobeRep = [tobeRep
               stringByReplacingOccurrencesOfString:@"]" withString:@""];
    tobeRep = [tobeRep
               stringByReplacingOccurrencesOfString:@"'" withString:@""];
    tobeRep = [tobeRep
               stringByReplacingOccurrencesOfString:@"[" withString:@""];
    tobeRep = [tobeRep
               stringByReplacingOccurrencesOfString:@"$" withString:@""];

    return tobeRep;

}

-(void)setUser:userName
{
    userName = [self getreplacedString:userName];
    usernameRef = [usersRef childByAppendingPath:userName];
}

-(void)setProject:userName
{

    userName = [self getreplacedString:userName];
    usernameRef = [usersRef childByAppendingPath:userName];
    projectRef = [usernameRef childByAppendingPath: @"Projects"];
}

-(void)addUser:fullName firstName:(NSString *)firstName lastName:(NSString *)lastName job:(NSString *)job specialties:(NSString *)specialties userName:(NSString *)userName
{
    userName = [self getreplacedString:userName];
    
    usernameRef = [usersRef childByAppendingPath:userName];
    
    NSDictionary *userDict = @{
                               @"First_Name" : firstName,
                               @"Last_Name": lastName,
                               @"Job": job,
                               @"Specialties":specialties,
                               @"User_Name":userName
                               };
    //project = @{projName:projDict};
    [usernameRef setValue:userDict];
}

-(void)updUser:fullName firstName:(NSString *)firstName lastName:(NSString *)lastName job:(NSString *)job specialties:(NSString *)specialties userName:(NSString *)userName
{
    userName = [self getreplacedString:userName];
    
    usernameRef = [usersRef childByAppendingPath:userName];
    
    NSDictionary *userDict = @{
                               @"First_Name" : firstName,
                               @"Last_Name": lastName,
                               @"Job": job,
                               @"Specialties":specialties,
                               @"User_Name":userName
                               };
    //project = @{projName:projDict};
    [usernameRef updateChildValues:userDict];
}


- (void)deleteUser:(NSString *)userName{
    userName = [self getreplacedString:userName];
    usernameRef = [usersRef childByAppendingPath:userName];
    NSDictionary *userDict = @{              };
    //project = @{projName:projDict};
    [usernameRef setValue:userDict];
}

-(void)addProjects:projName projectDesc:(NSString *)projectDesc projectDuration:(NSString *)projectDuration projLanguage:(NSString *)projLanguage
{
    
    projName = [self getreplacedString:projName];
    Firebase *projnameRef = [projectRef childByAppendingPath:projName];
    
    NSDictionary *projDict = @{
                               @"proj_name" : projName,
                               @"duration": projectDuration,
                               @"description":projectDesc,
                               @"programming_language_and_tech_used": projLanguage
                               };
    //project = @{projName:projDict};
    [projnameRef setValue:projDict];
}

-(void)updateProjects:projName projectDesc:(NSString *)projectDesc projectDuration:(NSString *)projectDuration projLanguage:(NSString *)projLanguage
{
    
    projName = [self getreplacedString:projName];
    Firebase *projnameRef = [projectRef childByAppendingPath:projName];
    
    NSDictionary *projDict = @{
                               @"proj_name" : projName,
                               @"duration": projectDuration,
                               @"description":projectDesc,
                               @"programming_language_and_tech_used": projLanguage
                               };
    //project = @{projName:projDict};
    [projnameRef updateChildValues:projDict];
}

- (void)deleteProject:(NSString *)projName{
 
    projName = [self getreplacedString:projName];
    Firebase *projnameRef = [projectRef childByAppendingPath:projName];
    NSDictionary *projDict = @{              };
    //project = @{projName:projDict};
    [projnameRef setValue:projDict];
}


- (void)detectUser:(NSString *)userName
{
   
    userName = [self getreplacedString:userName];
    [usersRef observeEventType:FEventTypeValue withBlock:^(FDataSnapshot *snapshot) {
        if(snapshot!=nil && snapshot.value!=nil && snapshot.value[userName]!=nil)
        {

            detectedUser = userName;
            
        }
        
        //NSLog(@"%@ -> %@", snapshot.key, snapshot.value);
    }];
    
}

- (void)detectProfile:(NSString *)userName
{
  
    
    detectedProfile = [[NSMutableArray alloc]init];
    [usernameRef observeEventType:FEventTypeValue withBlock:^(FDataSnapshot *snapshot) {
        if(snapshot!=nil && snapshot.value!=nil && snapshot.value[@"First_Name"]!=nil)
        {
            [detectedProfile addObject:snapshot.value[@"First_Name"]];
            [detectedProfile addObject:snapshot.value[@"Last_Name"]];
            [detectedProfile addObject:snapshot.value[@"Job"]];
            [detectedProfile addObject:snapshot.value[@"Specialties"]];
        }
        //NSLog(@"%@ -> %@", snapshot.key, snapshot.value);
    }];

}

- (void)detectProjects:(NSString *)userName
{
    
    detectedProjects = [[NSMutableArray alloc]init];
    
    [usernameRef observeEventType:FEventTypeValue withBlock:^(FDataSnapshot *snapshot) {
        if(snapshot!=nil && snapshot.value!=nil && snapshot.value[@"Projects"]!=nil)
        {
            [detectedProjects addObject:snapshot.value[@"Projects"]];
            
        }

        
    }];
    
}

- (NSMutableArray *)getDetectedProfile
{
    return detectedProfile;
}

- (NSMutableArray *)getDetectedProjects
{
    return detectedProjects;
}

- (NSString *)getDetectedUser
{
    return detectedUser;
}




- (void)setDetectedProfile:(NSMutableArray *)dProf
{
    detectedProfile = dProf;
}


- (void)registerUser:userName passWord:(NSString *)passWord cv:(UIViewController *)mainView{
    [ref createUser:userName password:passWord
 withValueCompletionBlock:^(NSError *error, NSDictionary *result) {
     
     if (error) {
         UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Error" message:@"Error in Registration" preferredStyle:UIAlertControllerStyleAlert];
         UIAlertAction *actionOk = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:nil];
         [alertController addAction:actionOk];
         [mainView presentViewController:alertController animated:YES completion:nil];
         
     } else {

         UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Registration Successful" message:@"You can now login" preferredStyle:UIAlertControllerStyleAlert];
         UIAlertAction *actionOk = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:nil];
         [alertController addAction:actionOk];
         [mainView presentViewController:alertController animated:YES completion:nil];

     }
 }];
}

- (void)authUser:userName passWord:(NSString *)passWord cv:(UIViewController *)mainView 
{
    [ref authUser:userName password:passWord
withCompletionBlock:^(NSError *error, FAuthData *authData) {
    
    if (error) {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Error in authentication" message:@"Error in Logging"preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *actionOk = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:nil];
        [alertController addAction:actionOk];
        [mainView presentViewController:alertController animated:YES completion:nil];
    } else {
        UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main"                        bundle:nil];
        CrudViewController *cv = [storyboard instantiateViewControllerWithIdentifier:@"crudview"];
        cv.userName = userName;
        [mainView presentViewController:cv animated:NO completion:nil];
    }
}];
}





@end
