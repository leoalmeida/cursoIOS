//
//  ViewController.h
//  FirstContacts
//
//  Created by ios2686 on 08/05/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ContatoProtocol.h"

@interface ViewController : UITableViewController <ContatoProtocol>

@property(strong, nonatomic) NSMutableArray *contatos; 

@end
