//
//  ViewController.m
//  FirstContacts
//
//  Created by ios2686 on 08/05/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController


@synthesize contatos = _contatos;

-(void) viewDidLoad{
    [super viewDidLoad];
    self.title = @"Contatos";
    self.contatos = [[NSMutableArray alloc] initWithObjects:
                     @"Caelum RJ", 
                     @"Caelum SP", 
                     @"Caelum BSB",
                     @"Caelum BSB",
                     @"Caelum BSB",
                     @"Caelum BSB",
                     @"Caelum BSB",
                     @"Caelum BSB",
                     @"Caelum BSB",
                     @"Caelum BSB",
                     @"Caelum BSB",
                     @"Caelum BSB",
                     @"Caelum BSB",
                     @"Caelum BSB",
                     @"Caelum BSB",
                     @"Caelum BSB", nil];
    
}

-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.contatos count];
}

-(UITableViewCell *)tableView:(UITableView *)tabela cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tabela dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier]; 
    }
    cell.textLabel.text = [self.contatos objectAtIndex:indexPath.row];
    return cell;
}

@end
