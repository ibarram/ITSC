#include <stdio.h>
#include <dirent.h>
#include <string.h>
#include <stdlib.h>
#include "ITSC.h"

lt *lt_inicio(lt* lt1)
{
	if(lt1==NULL)
		return lt1;
	else if(lt1->p==NULL)
		return lt1;
	else
		return lt_inicio(lt1->p);
}

int lt_count(lt* lt1)
{
	if(lt1==NULL)
		return 0;
	else
		return lt_count(lt1->n)+1;
}

lt *load_raw(char *path_root)
{
	lt *lt_c=NULL, *lt_n;
	int nc, it, fA, fB, fC, nf, n_d, n_s, i;
	DIR *d;
	struct dirent *dir;
	FILE *fp;
	char str_file[200], c;
	d = opendir(path_root);
	if (d) {
		while ((dir = readdir(d)) != NULL) {
			nc = strlen(dir->d_name);
			if((dir->d_type==8)&&(strncmp(dir->d_name+nc-4,".csv",4)==0)) {
				lt_n = (lt*)malloc(sizeof(lt));
				if(lt_n==NULL) {
					return NULL;
				}
				lt_n->p=lt_c;
				if(lt_n->p!=NULL)
					lt_c->n=lt_n;
				lt_n->n=NULL;
				if(strncmp(dir->d_name, "SC_HLT", 6)==0) {
					sscanf(dir->d_name, "SC_HLT_%d", &it);
					fA = 0;
					fB = 0;
					fC = 0;
				}
				else
					sscanf(dir->d_name, "SC_A%d_B%d_C%d_%d", &fA, &fB, &fC, &it);
				lt_n->s.it = it;
				lt_n->s.fA = fA*10;
				lt_n->s.fB = fB*10;
				lt_n->s.fC = fC*10;
				strcpy(str_file,path_root);
				strcat(str_file,dir->d_name);
				fp=fopen(str_file, "rt");
				if(fp==NULL)
					return NULL;
				n_s = 0;
				n_d = 0;
				do{
					c = getc(fp);
					if(c==',')
						n_d++;
					else if(c==10) {
						n_d++;
						n_s++;
					}
				}while(c != EOF);
				if(n_d/3!=n_s)
					return NULL;
				fseek(fp, 0, SEEK_SET);
				lt_n->s.n = n_s;
				lt_n->s.A = (float*)malloc(n_d*sizeof(float));
				if(lt_n->s.A==NULL)
					return NULL;
				lt_n->s.B = lt_n->s.A+n_s;
				lt_n->s.C = lt_n->s.B+n_s;
				for(i=0; i<n_s; i++)
					fscanf(fp, "%f,%f,%f\n", lt_n->s.A+i, lt_n->s.B+i, lt_n->s.C+i);
				fclose(fp);
				lt_c = lt_n;
			}
		}
		closedir(d);
	}
	lt_c = lt_inicio(lt_n);
	return lt_c;
}

void signal2str(lt *lt_c, char *str)
{
	if(lt_c->s.fA||lt_c->s.fB||lt_c->s.fC)
		sprintf(str, "SC_A%d_B%d_C%d", lt_c->s.fA/10, lt_c->s.fB/10, lt_c->s.fC/10);
	else
		sprintf(str, "SC_HLT");
}

int labelcmp(char *str1, char *str2)
{
	int n_str1, n_str2;
	if(strcmp(str1, "SC_HLT")==0)
		return -1;
	else if(strcmp(str2, "SC_HLT")==0)
		return 1;
	else {
		n_str1 = 100*(str1[4]-'0')+10*(str1[7]-'0')+(str1[10]-'0');
		n_str2 = 100*(str2[4]-'0')+10*(str2[7]-'0')+(str2[10]-'0');
		return n_str2-n_str1;
	}
}

int build_db(db *db1)
{
	int nf, nc, *h, i, j, aux, flag, *id1;
	char **cls_name, *str_cls;
	lt *lt_c;
	cls *cls_1;
	nf = lt_count(db1->lt_h);
	h=(int*)calloc(nf,sizeof(int));
	if(h==NULL)
		return 1;
	cls_name=(char**)malloc(nf*sizeof(char*));
	if(cls_name==NULL)
		return 2;
	str_cls = (char*)malloc(12*sizeof(char));
	if(str_cls==NULL)
		return 3;
	lt_c = db1->lt_h;
	signal2str(lt_c, str_cls);
	cls_name[0] = str_cls;
	h[0]++;
	for(i=1; i<nf; i++)
		cls_name[i] = NULL;
	str_cls = (char*)malloc(12*sizeof(char));
	if(str_cls==NULL)
		return 3;
	nc = 1;
	lt_c=lt_c->n;
	while(lt_c!=NULL) {
		signal2str(lt_c, str_cls);
		for(i=0, flag=1; i<nc; i++) {
			if(!strcmp(str_cls, cls_name[i])){
				flag = 0;
				h[i]++;
				break;
			}
		}
		if(flag) {
			cls_name[nc] = str_cls;
			h[nc]++;
			nc++;
			str_cls = (char*)malloc(12*sizeof(char));
			if(str_cls==NULL)
				return 3;
		}
		lt_c=lt_c->n;
	}
	if(flag)
		free(str_cls);
	id1=(int*)malloc(nc*sizeof(int));
	if(id1==NULL)
		return 4;
	for(i=0; i<nc; i++)
		id1[i]=i;
	for(i=1; i<nc; i++) {
		aux = id1[i];
		j=i-1;
		while(j>-1) {
			if(labelcmp(cls_name[id1[j]],cls_name[aux])>0)
				break;
			id1[j+1]=id1[j];
			j--;
		}
		j++;
		id1[j]=aux;
	}
	cls_1 = (cls*)malloc(nc*sizeof(cls));
	if(cls_1==NULL)
		return 5;
	for(i=0; i<nc; i++) {
		strcpy(cls_1[i].name, cls_name[id1[i]]);
		cls_1[i].n = h[id1[i]];
		cls_1[i].s = (tsignal**)malloc(h[id1[i]]*sizeof(tsignal*));
		if(cls_1[i].s==NULL)
			return 6;
	}
	str_cls = (char*)malloc(12*sizeof(char));
	if(str_cls==NULL)
		return 3;
	lt_c = db1->lt_h;
	while(lt_c!=NULL) {
		signal2str(lt_c, str_cls);
		for(i=0; i<nc; i++)
			if(strcmp(str_cls, cls_1[i].name)==0)
				break;
		cls_1[i].s[lt_c->s.it-1] = &(lt_c->s);
		lt_c = lt_c->n;
	}
	db1->n = nc;
	db1->cls_h = cls_1;
	free(str_cls);
	free(id1);
	do{
		free(cls_name[i]);
		i++;
	}while(cls_name[i]!=NULL);
	free(cls_name);
	free(h);
	return 0;
}

int load_data_raw(db *db1, char *path_root)
{
	int n_er;
	db1->lt_h = load_raw(path_root);
	n_er = build_db(db1);
	return n_er;
}

void show_db(db db1)
{
	int nf, i, j, k;
	nf = lt_count(db1.lt_h);
	printf("\nNumber of files: %d\n", nf);
	printf("Number of classes: %d\n", db1.n);
	for(i=0; i<db1.n; i++) {
		printf("\nClass label: %s\n", db1.cls_h[i].name);
		printf("Number of iterations: %d\n", db1.cls_h[i].n);
		printf("Failure percentage par phase: A (%d%%), B(%d%%), C(%d%%)\n",
			db1.cls_h[i].s[0]->fA, db1.cls_h[i].s[0]->fB, db1.cls_h[i].s[0]->fC);
		for(j=0; j<db1.cls_h[i].n; j++) {
			printf("\tIteration number: %d\n", db1.cls_h[i].s[j]->it);
			printf("\tNumber of samples: %d\n", db1.cls_h[i].s[j]->n);
			printf("\t\tsample\tA\tB\tC\n");
			for(k=0; k<5; k++)
				printf("\t\t%d\t%.2f\t%.2f\t%.2f\n", 
					k+1, db1.cls_h[i].s[j]->A[k], db1.cls_h[i].s[j]->B[k], db1.cls_h[i].s[j]->C[k]);
		}
	}
}

int summarized(db db1)
{
	int nf, i, j, k, *ts;
	nf = lt_count(db1.lt_h);
	printf("\nNumber of files: %d\n", nf);
	printf("Number of classes: %d\n", db1.n);
	ts=(int*)calloc(db1.n,sizeof(int));
	if(ts==NULL)
		return 1;
	for(i=0; i<db1.n; i++)
		for(j=0; j<db1.cls_h[j].n; j++)
			ts[i]+=(db1.cls_h[i].s[j]->n);
	printf("Name\t\tIteracion\tTotal samples\n");
	for(i=0; i<db1.n; i++)
			printf("%d. %s\t    %d\t\t   %d\n", i+1, db1.cls_h[i].name, db1.cls_h[i].n, ts[i]);
	free(ts);
	return 0;
}

int search_class(db db1, char *str_cls)
{
	int id, i;
	for(i=0, id=-1; i<db1.n; i++)
		if(strcmp(db1.cls_h[i].name,str_cls)==0)
			return i;
	return id;
}

int find_class(db db1, int fA, int fB, int fC)
{
	int id, i;
	for(i=0, id=-1; i<db1.n; i++)
		if((db1.cls_h[i].s[0]->fA==fA)&&(db1.cls_h[i].s[0]->fB==fB)&&(db1.cls_h[i].s[0]->fC==fC))
			return i;
	return id;
}
