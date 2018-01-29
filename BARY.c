#include <string.h>
#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include "fitsio.h"

void printerror( int status);
void PRINTTIME(char *orbfile,char *evtfptr);


int main(int argc, char **argv)
{
   printf("ORBIT file name	: %s \n",argv[1]);
   printf("EVENT file name	: %s \n",argv[2]);
PRINTTIME(argv[1],argv[2]);
return 0;
}
void PRINTTIME(char *orbfile,char *evtfile)
{
	double tstart,tstop,evttstart,evttstop,doublenull;
	double *evttime;
	int i,j,ii,k,status,hdunum=2,intnull,timecolnum,size=1,anynull;
	long *index,*delrow;
	long frow, felem, nelem,evtnrows, longnull;
	unsigned char bytenull;
	fitsfile *orbfptr,*evtfptr;
	status=0;

	evttime  = (double*)malloc(size * sizeof(double));
	index  = (long*)malloc(size * sizeof(long));
	//int[] array = new int[1000];
	//ORBIT FILE READ
		if ( fits_open_file(&orbfptr, orbfile, READONLY, &status) )
		{
	    	printf("Error in opening a file : %d\n",status);
	   	 printerror( status );
		}
		if(fits_movabs_hdu(orbfptr, 2, NULL, &status)) 
		  printerror( status ); 
		fits_read_key(orbfptr,TDOUBLE,"TSTART",&tstart,NULL, &status);
		fits_read_key(orbfptr,TDOUBLE,"TSTOP",&tstop,NULL, &status);
          	printf("Orb Time : TSTART: %f\t TSTOP: %f\n",tstart,tstop); 

	//EVENT FILE READ
		if ( fits_open_file(&evtfptr, evtfile, READWRITE, &status) )
		{
	   	 printf("Error in opening a file : %d\n",status);
	    	printerror( status );
		}
	
         for(i=0;i<=3;i++)
    	{
		ii=0;
	     if(fits_movabs_hdu(evtfptr,i+hdunum, 0, &status)) 
			printerror( status ); 
			fits_read_key(evtfptr,TDOUBLE,"TSTART",&evttstart,NULL, &status);
			fits_read_key(evtfptr,TDOUBLE,"TSTOP",&evttstop,NULL, &status); 
			//printf("Evt time for Quad %d :TSTART: %f\t TSTOP: %f\n",i,evttstart,evttstop); 
		fits_get_num_rows(evtfptr, &evtnrows, &status);
		evttime  = (double*)realloc(evttime,evtnrows * sizeof(double));
		index  = (long*)realloc(index,evtnrows * sizeof(long));
		fits_get_colnum(evtfptr, CASEINSEN, "Time", &timecolnum, &status);	
		frow      = 1;	
		felem     = 1;
		doublenull = 0.;
		intnull = 0;
		bytenull = 0;
	         fits_read_col(evtfptr, TDOUBLE, timecolnum, frow, felem, evtnrows, &doublenull, evttime, &anynull, &status);
		//printf("evt time :%f\n",evttime[evtnrows-1]);
		//printf("time column no :%d\n",timecolnum);
		for(j=0;j< evtnrows;j++)
		{
			if((evttime[j] < tstart+2) || (evttime[j] >= tstop-2))
			{
				index[ii]=j+1;
				printf("%f %d\n",evttime[j],index[ii]);
				ii++;	
			//printf("count %d",sizeof(index[ii]));
	
			}
 				
		}
		delrow  = (long*)malloc(ii * sizeof(long));
		for(k=0; k<ii; k++)
    		{
               		delrow[k]=index[k];
            		printf("INDEX RANGE : %d\n",delrow[k]);	
		}
		//printf("iNDEX RANGE : %d - %d\n",index[ii],index[ii-1]);

		
		fits_delete_rowlist(evtfptr,delrow,ii,&status);
		if(status==0){
	        		 printerror( status );
                  	 printf("Rows are deleted successfully\n");
			}
		else{	
			printerror( status ); 
			printf("Problem in deleting rows\n");		
                       }

       }
 	if ( fits_close_file(orbfptr, &status) )       
	        printerror( status );
 	if ( fits_close_file(evtfptr, &status) )       
	        printerror( status );
}
	void printerror( int status)
	{
	if (status)
	{
		fits_report_error(stderr, status); 	
		exit( status );    	
    	}
  	return;
	}
