//
//  hanoi.c
//  hanoi
//
//  Created by Phantom on 2019/10/31.
//  Copyright © 2019. All rights reserved.
//

#include <stdio.h>

void Move(int base, char x,char y){
    printf("%d, %c -> %c\n", base, x, y);
}
void hannuo(int n,char one ,char two,char three){
    if(n==1){
        Move(n, one, two);
        Move(n, two, three);
        return;
    }
  else{
      hannuo(n-1,one , two, three);
      Move(n, one,two);
      hannuo(n-1, three, two, one);
      Move(n, two, three);
      hannuo(n-1, one, two, three);
  }
}

int main(){
    int n;
    scanf("%d",&n);
    for(int i = 0; i < n; i ++){
        int a;
        scanf("%d", &a);
        hannuo(a,'A','B','C');
        puts("");
    }
    return 0;
}
