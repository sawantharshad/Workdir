import sys
from astropy.io import fits
hdulist = fits.open('/home/assc/Documents/AS1A03_086T01_9000001568cztM0_level2_quad_clean_Q0_new.pha')
hdulist.info()
hdu = hdulist[1]
hdu.header
hdu.header['EXPOSURE'] = 9.555
hdulist.writeto('/home/assc/Documents/AS1A03_086T01_9000001568cztM0_level2_quad_clean_Q0_new.pha',clobber=True)




Info: Get proposalid++++user+++++++----------------------------------T01_003
Info: Get proposalid++++after+++++++----------------------------------T01_003
Info: In -------email id---------------------------pgaurav@issc.unipune.ac.in
Info: In --------username------------------------harsha
Info: In ----------fullname------------------------gaurav santosh panchariya
Info: In Register function----------------------------------sreekumar@iiap.res.in
Info: Mon Jan 22 02:19:24 IST 2018,voi.pms.auth.Sendmail - === EMAIL SEND TO = sreekumar@iiap.res.in
Info: Mon Jan 22 02:19:24 IST 2018,voi.pms.auth.Sendmail - === EMAIL SEND BCC = null
Info: Mon Jan 22 02:19:24 IST 2018,voi.pms.auth.Sendmail - === SUBJECT = testsubject
Info: Mon Jan 22 02:19:24 IST 2018,voi.pms.auth.Sendmail - === CONTENT = 
testMessege
