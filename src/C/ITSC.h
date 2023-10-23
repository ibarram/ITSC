#ifndef ITSC_H
#define ITSC_H

#include <stdio.h>
#include <dirent.h>
#include <string.h>
#include <stdlib.h>

typedef struct tsignal{
	int it, fA, fB, fC, n;
	float *A,*B,*C;
}tsignal;

typedef struct lt{
	struct tsignal s;
	struct lt *p, *n;
}lt;

typedef struct cls{
	char name[20];
	int n;
	struct tsignal **s;
}cls;

typedef struct db{
	int n;
	struct cls *cls_h;
	lt *lt_h;
}db;

lt *lt_inicio(lt* lt1);
int lt_count(lt* lt1);
lt *load_raw(char *path_root);
void signal2str(lt *lt_c, char *str);
int labelcmp(char *str1, char *str2);
int build_db(db *db1);
int load_data_raw(db *db1, char *path_root);
void show_db(db db1);
int summarized(db db1);
int search_class(db db1, char *str_cls);
int find_class(db db1, int fA, int fB, int fC);

#endif