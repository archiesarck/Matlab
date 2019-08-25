#include <stdio.h>
#include <string.h>
#include <sys/types.h>
#include <dirent.h>
#include <stdlib.h>

int check(char *sentence, char *word){
	int s = (int)strlen(sentence);
	int w = (int)strlen(word);
	int cnt = 0;
	for(int i = 0; i<(s-w); i++){
		cnt = 0;
		for(int j = 0; j<w; j++){
			if(sentence[j+i]==word[j]) cnt += 1;
		}
		if(cnt==w){
			printf("%s\n", sentence);
			return 1;
		}
	}
	return 0;
}

void listall(char *dirname, char *key){
	DIR *dir = opendir(dirname);
	if(dir==NULL){
		// printf("%s\n", dirname);
		FILE *fp;
		fp = fopen(dirname, "r");
		if(fp!=NULL){
			ssize_t read;
			size_t len = 0;
			char *line = NULL;
			while((read = getline(&line, &len, fp))!=-1){
				//printf("Hello\n");
				int x = check(line, key);
				if(x) printf("File: %s\n\n", dirname);
			}
		}
	}
	else{
		struct dirent *entry;
		
		while((entry = readdir(dir))!=NULL){
			char path[1024];
			if((strcmp(entry->d_name,"."))&&(strcmp(entry->d_name,".."))){
				snprintf(path, sizeof(path), "%s/%s", dirname, entry->d_name);
				listall(path, key);
			}
		}
	}
	closedir(dir);

	return;
}

int main(){
	char name[500];

	char key[100];
	scanf("%s", name);
	scanf("%s", key);

	listall(name, key);

	return 0;
}