/* -----------------------------------------------------------------------------
 * objc.swg
 *
 * Objective-C module typemaps: 
 * Note that the intermediate layer (ObjectiveC++) is essentially a C layer with the 
 * C++ specific code (such as references) converted to the C code. Since ObjectiveC
 * layer can handle C as is, this makes sense - at least until we decide on something 
 * more appropriate.

 * ----------------------------------------------------------------------------- */

/* 
 * IMTYPE TYPEMAPS: Represents the ObjectiveC++ type corresponding to each C++ type. 
 */
 
// Primary types: ObjectiveC++ understands C primary types.
%typemap(imtype) char, const char &                      "char"
%typemap(imtype) signed char, const signed char &        "signed char"
%typemap(imtype) unsigned char, const unsigned char &    "unsigned char"
%typemap(imtype) short, const short &                    "short"
%typemap(imtype) unsigned short, const unsigned short &  "unsigned short"
%typemap(imtype) int, const int &                        "int"
%typemap(imtype) unsigned int, const unsigned int &      "unsigned int"
%typemap(imtype) long, const long &                      "long"
%typemap(imtype) unsigned long, const unsigned long &    "unsigned long"
%typemap(imtype) long long, const long long &            "long long"
%typemap(imtype) unsigned long long, const unsigned long long & "unsigned long long"
%typemap(imtype) float, const float &                    "float"
%typemap(imtype) double, const double &                  "double"
%typemap(imtype) void                                    "void"

// References to primitive types are treated as pointers in the wrapper(ObjectiveC++) layer.
%typemap(imtype) char &                  "char *"
%typemap(imtype) signed char &           "signed char *"
%typemap(imtype) unsigned char &         "unsigned char *"
%typemap(imtype) short &                 "short *"
%typemap(imtype) unsigned short &        "unsigned short *"
%typemap(imtype) int &                   "int *"
%typemap(imtype) unsigned int &          "unsigned int *"
%typemap(imtype) long &                  "long *"
%typemap(imtype) unsigned long &         "unsigned long  *"
%typemap(imtype) long long &             "long long *"
%typemap(imtype) unsigned long long &    "unsigned long long  *"
%typemap(imtype) float &                 "float *"
%typemap(imtype) double &                "double *"

// Booleans
%typemap(imtype) bool, const bool &      "BOOL"
%typemap(imtype) bool &, const bool *, bool * "BOOL *"

// C strings:
%typemap(imtype) char *, const char *, char[ANY], char[]              "NSString *"
%typemap(imtype) char *&                                "NSString *"

// Objects will always be treated as pointers in ObjectiveC++
%typemap(imtype) SWIGTYPE                               "void *"

// C/C++ prinitve pointers are treated as is in ObjectiveC++
// References to primitive types are treated as pointers in the wrapper(ObjectiveC++) layer.
%typemap(imtype) const signed char *, 		signed char *           "signed char *"
%typemap(imtype) const unsigned char *, 	unsigned char *         "unsigned char *"
%typemap(imtype) const short *,				short *                 "short *"
%typemap(imtype) const unsigned short *,	unsigned short *        "unsigned short *"
%typemap(imtype) const int *,		    	int *                   "int *"
%typemap(imtype) const unsigned int *,		unsigned int *          "unsigned int *"
%typemap(imtype) const long *,				long *                  "long *"
%typemap(imtype) const unsigned long *, 	unsigned long *         "unsigned long  *"
%typemap(imtype) const long long *, 		long long *             "long long *"
%typemap(imtype) const unsigned long long *,unsigned long long *    "unsigned long long  *"
%typemap(imtype) const float *, 			float *                 "float *"
%typemap(imtype) const double *,  			double *                "double *"
%typemap(imtype) const void *,                          void *                  "void *"

// C/C++ object Pointers, are treated as void* in ObjectiveC++
%typemap(imtype) SWIGTYPE *                             "void *"

// Arrays for non-primitive types
%typemap(imtype) SWIGTYPE []                            "void *"

// Pointer to a class member will be void*
%typemap(imtype) SWIGTYPE (CLASS::*)                    "void *"  

// References to non-primitive types
%typemap(imtype) SWIGTYPE &                             "void *"
%typemap(imtype) SWIGTYPE *const&                       "void *"

// Function pointers
%typemap(imtype) SWIGTYPE ((*)(ANY))                    "void *"

/* 
 * IN TYPEMAPS: Used for "in" arguments type conversions: ObjectiveC++ to C++.
 */
%typemap(in) char, 
             signed char, 
             unsigned char, 
             short, 
             unsigned short, 
             int, 
             unsigned int, 
             long, 
             unsigned long, 
             long long, 
             unsigned long long,
             float, 
             double
%{ $1 = ($1_ltype)$input; %}

%typemap(directorout) char, 
             signed char, 
             unsigned char, 
             short, 
             unsigned short, 
             int, 
             unsigned int, 
             long, 
             unsigned long, 
             long long, 
             float, 
             double
%{ $result = ($1_ltype)$input; %}

// No "in" for void
%typemap(in) void ""
%typemap(objcdirectorin) void "$iminput"
%typemap(objcdirectorout) void "$objccall"
%typemap(directorin) void ""

// References: are treated as pointers in the wrapper layer (ObjectiveC++)
%typemap(in) const char & ($*1_ltype temp),
             const signed char & ($*1_ltype temp),
             const unsigned char & ($*1_ltype temp),
             const short & ($*1_ltype temp),
             const unsigned short & ($*1_ltype temp),
             const int & ($*1_ltype temp),
             const unsigned int & ($*1_ltype temp),
             const long & ($*1_ltype temp),
             const unsigned long & ($*1_ltype temp),
             const long long & ($*1_ltype temp),
             const float & ($*1_ltype temp),
             const double & ($*1_ltype temp)
%{ temp = ($*1_ltype)$input;
   $1 = &temp; %}

%typemap(in)	char &,
	     	signed char &,
	      	unsigned char &,
		short &,
		unsigned short &,
		int &,
		unsigned int &,
		long &,
		unsigned long &,
		long long &,
		unsigned long long &,
		float &,
		double &
%{ $1 = ($1_ltype)$input; %}

%typemap(in) const signed char *, 		signed char *,           
 	const unsigned char *, 	        unsigned char *,         
 	const short *,				short *,                 
 	const unsigned short *,	        unsigned short *,        
 	const int *,		    	int *,                   
 	const unsigned int *,		unsigned int *,          
 	const long *,				long *,                 
 	const unsigned long *, 	        unsigned long *,         
 	const long long *, 		long long *,             
 	const unsigned long long *,     unsigned long long *,    
 	const float *, 			float *,               
 	const double *,  	        double *        
%{ $1 = ($1_ltype)$input;%}

//Booleans:
%typemap(in) const bool & ($*1_ltype temp)
%{ temp = ($*1_ltype)$input;
   $1 = &temp; %}

%typemap(in) bool
%{ $1 = $input != NO; %}

%typemap(directorout) bool
%{ $result = $input != NO; %}

%typemap(in) bool * (bool temp), const bool * (bool temp), bool & (bool temp) {
  temp = ($input) != NO;
  $1 = &temp;
}


//C strings:
%typemap(in) char *, char[ANY], char[]  {
 $1 = 0;
  if ($input) {
		$1 = ($1_ltype)[$input UTF8String];
	}
}

%typemap(in) char *& ($*1_ltype temp = 0) {
 $1 = 0;
  if ($input) {
		temp = ($*1_ltype)[$input UTF8String];
  }
  $1 = &temp;
}

// Objects passed by value: convert from a pointer to the C++ value object.
%typemap(in) SWIGTYPE ($&1_type argp)
%{ argp = ($&1_ltype)$input;
   if (!argp) {
     SWIG_ObjcThrowException(SWIG_ObjcNullPointerException, "$1_type is null");
     return $null;
   }
   $1 = *argp; %}

%typemap(directorout) SWIGTYPE ($&1_type argp)
%{ argp = *($&1_ltype*)&$input; 
   if (!argp) {
     SWIG_ObjcThrowException(SWIG_ObjcNullPointerException, "Unexpected null return for type $1_type");
     return $null;
   }
   $result = *argp; %}

// C/C++ Pointers, primary and object, are treated as pointers in ObjectiveC++
%typemap(in) SWIGTYPE *
%{ $1 = ($1_ltype)$input; %}
   
// Object References
%typemap(in) SWIGTYPE & %{ $1 = ($1_ltype)$input;
  if (!$1) {
    SWIG_ObjcThrowException(SWIG_ObjcNullPointerException, "$1_type reference is null");
    return $null;
  } %}

%typemap(in) SWIGTYPE *const& ($*1_ltype temp = 0)
%{ temp = *($1_ltype)&$input;
   $1 = ($1_ltype)&temp; %}
   
// Array conversion typemap
%typemap(in) SWIGTYPE [] %{ $1 = ($1_ltype)$input; %}

// Pointer to a class member will be passed as void*, convert appropriately
%typemap(in) SWIGTYPE (CLASS::*)
%{ $1 = *($&1_ltype)$input; %}

// Function pointers
%typemap(in) SWIGTYPE ((*)(ANY))
%{ $1 = ($1_ltype)$input; %}

%typemap(in) SWIGTYPE *& ($*1_ltype temp = 0)
%{ temp = *($1_ltype)&$input;
   $1 = &temp; %}

/*
 * OUT TYPEMAPS: Used for return-type type conversions: C++ to ObjectiveC++
 */
//Primary types
%typemap(out) char               %{ $result = (char)$1; %}
%typemap(out) signed char        %{ $result = (signed char)$1; %}
%typemap(out) unsigned char      %{ $result = (unsigned char)$1; %}
%typemap(out) short              %{ $result = (short)$1; %}
%typemap(out) unsigned short     %{ $result = (unsigned short)$1; %}
%typemap(out) int                %{ $result = (int)$1; %}
%typemap(out) unsigned int       %{ $result = (unsigned int)$1; %}
%typemap(out) long               %{ $result = (long)$1; %}
%typemap(out) unsigned long      %{ $result = (unsigned long)$1; %}
%typemap(out) long long          %{ $result = (long long)$1; %}
%typemap(out) unsigned long long %{ $result = (unsigned long long)$1; %}
%typemap(out) float              %{ $result = (float)$1; %}
%typemap(out) double             %{ $result = (double)$1; %}

%typemap(directorin) char,
		     signed char,
                     unsigned char,
                     short,
                     unsigned short,
                     int,
                     unsigned int,
                     long,
                     unsigned long,
                     long long,
                     float,
                     double
  "$input = $1;"

%typemap(objcdirectorin) char, 
                         signed char, 
                         unsigned char, 
                         short, 
                         unsigned short, 
                         int, 
                         unsigned int, 
                         long, 
                         unsigned long, 
                         long long, 
                         float, 
                         double
  "$iminput"
%typemap(objcdirectorout) char, 
                         signed char, 
                         unsigned char, 
                         short, 
                         unsigned short, 
                         int, 
                         unsigned int, 
                         long, 
                         unsigned long, 
                         long long, 
                         float, 
                         double
  "$objccall"

%typemap(out) void ""

// References as exported as pointers (by default)
%typemap(out) const char &               %{ $result = (char)*$1; %}
%typemap(out) const signed char &        %{ $result = (signed char)*$1; %}
%typemap(out) const unsigned char &      %{ $result = (unsigned char)*$1; %}
%typemap(out) const short &              %{ $result = (short)*$1; %}
%typemap(out) const unsigned short &     %{ $result = (unsigned short)*$1; %}
%typemap(out) const int &                %{ $result = (int)*$1; %}
%typemap(out) const unsigned int &       %{ $result = (unsigned int)*$1; %}
%typemap(out) const long &               %{ $result = (long)*$1; %}
%typemap(out) const unsigned long &      %{ $result = (unsigned long)*$1; %}
%typemap(out) const long long &          %{ $result = (long long)*$1; %}
%typemap(out) const unsigned long long & %{ $result = (unsigned long long)*$1; %}
%typemap(out) const float &              %{ $result = (float)*$1; %}
%typemap(out) const double &             %{ $result = (double)*$1; %}

%typemap(directorout,warning=SWIGWARN_TYPEMAP_THREAD_UNSAFE_MSG) const char &,
             const signed char &,
             const unsigned char &,
             const short &,
             const unsigned short &,
             const int &,
             const unsigned int &,
             const long &,
             const unsigned long &,
             const long long &,
             const float &,
             const double &
%{ static $*1_ltype temp;
   temp = ($*1_ltype)$input;
   $result = &temp; %}

%typemap(directorout,warning=SWIGWARN_TYPEMAP_THREAD_UNSAFE_MSG) const bool &
%{ static $*1_ltype temp;
   temp = $input != NO;
   $result = &temp; %}

%typemap(directorin) const char &               %{ $input = (char)$1; %}
%typemap(directorin) const signed char &        %{ $input = (signed char)$1; %}
%typemap(directorin) const unsigned char &      %{ $input = (unsigned char)$1; %}
%typemap(directorin) const short &              %{ $input = (short)$1; %}
%typemap(directorin) const unsigned short &     %{ $input = (unsigned short)$1; %}
%typemap(directorin) const int &                %{ $input = (int)$1; %}
%typemap(directorin) const unsigned int &       %{ $input = (unsigned int)$1; %}
%typemap(directorin) const long &               %{ $input = (long)$1; %}
%typemap(directorin) const unsigned long &      %{ $input = (unsigned long)$1; %}
%typemap(directorin) const long long &          %{ $input = (long long)$1; %}
%typemap(directorin) const unsigned long long & %{ $input = (unsigned long long)$1; %}
%typemap(directorin) const float &              %{ $input = (float)$1; %}
%typemap(directorin) const double &             %{ $input = (double)$1; %}

%typemap(objcdirectorin) const char & ($*1_ltype temp),
                         const signed char & ($*1_ltype temp),
                         const unsigned char & ($*1_ltype temp),
                         const short & ($*1_ltype temp),
                         const unsigned short & ($*1_ltype temp),
                         const int & ($*1_ltype temp),
                         const unsigned int & ($*1_ltype temp),
                         const long & ($*1_ltype temp),
                         const unsigned long & ($*1_ltype temp),
                         const long long & ($*1_ltype temp),
                         const float & ($*1_ltype temp),
                         const double & ($*1_ltype temp)
  "$iminput"

%typemap(objcdirectorout) const char & ($*1_ltype temp),
                          const signed char & ($*1_ltype temp),
                          const unsigned char & ($*1_ltype temp),
                          const short & ($*1_ltype temp),
                          const unsigned short & ($*1_ltype temp),
                          const int & ($*1_ltype temp),
                          const unsigned int & ($*1_ltype temp),
                          const long & ($*1_ltype temp),
                          const unsigned long & ($*1_ltype temp),
                          const long long & ($*1_ltype temp),
                          const float & ($*1_ltype temp),
                          const double & ($*1_ltype temp)
  "$objccall"

%typemap(out)			char &,
	     	  		signed char &,
	         		unsigned char &,
				short &,
				unsigned short &,
			    	int &,
				unsigned int &,
				long &,
			 	unsigned long &,
				long long &,
				unsigned long long &,
				float &,
				double &
%{ $result = $1; %}


%typemap(out)const char *,  			char *,
	     	 const signed char *, 		signed char *,
	         const unsigned char *, 	unsigned char *,
		     const short *,				short *,
		     const unsigned short *,	unsigned short *,
		     const int *,		    	int *,
		     const unsigned int *,		unsigned int *,
			 const long *,				long *,
	     	 const unsigned long *, 	unsigned long *,
	     	 const long long *, 		long long *,
	     	 const unsigned long long *,unsigned long long *,
	      	 const float *, 			float *,
	      	 const double *,  			double *
%{ $result = $1; %}

// Booleans:
%typemap(out) bool
%{ $result = ($1) ? YES : NO; %}

%typemap(out) const bool &
%{ $result = (*$1) ? YES : NO; %}

%typemap(directorin) bool
  "$input = ($1) ? YES : NO;"

%typemap(directorin) const bool &
  "$input = ($1) ? YES : NO;"

%typemap(objcdirectorin) bool
  "($iminput) ? YES : NO"

%typemap(objcdirectorin) const bool & 
  "($iminput) ? YES : NO"

%typemap(objcdirectorout) bool
  "($objccall) != NO"

%typemap(objcdirectorout) const bool &
  "($objccall) != NO"

%typemap(out) bool& (BOOL temp), bool* (BOOL temp)
%{ temp = (*$1)? YES : NO;
   BOOL* ret = &temp;
   return ret; %}

// C strings: 
%typemap(out)const char *,char * %{ if ($1) $result = [NSString stringWithUTF8String: (const char*)$1]; %}
%typemap(out) char *& %{ if (*$1) $result = [NSString stringWithUTF8String: (const char*)*$1]; %}
%typemap(out) char[ANY], char[] %{ if ($1) $result = [NSString stringWithUTF8String: (const char*)$1]; %}

// Objects returned by value: convert to a pointer.
%typemap(out) SWIGTYPE ($&1_type temp)
#ifdef __cplusplus
%{
  temp = new $1_ltype((const $1_ltype &)$1); 
  $result = (void *)temp;
%}
#else
{
  $&1_ltype $1ptr = ($&1_ltype) malloc(sizeof($1_ltype));
  memmove($1ptr, &$1, sizeof($1_type));
  temp = $1ptr;
  $result = (void *)temp;
}
#endif

%typemap(directorin) SWIGTYPE 
%{
  $input = &$1;
%}
%typemap(objcdirectorin) SWIGTYPE "[[$objcclassname_stripped alloc] initWithCptr:$iminput swigOwnCObject:NO]"
%typemap(objcdirectorout) SWIGTYPE "[($objccall) getCptr]"

// Pointer objects are returned as void* in the ObjectiveC++ layer
%typemap(out) SWIGTYPE *, SWIGTYPE & 
%{ $result = (void *)$1; %}

%typemap(out) SWIGTYPE [] %{ $result = $1; %}

%typemap(directorin) SWIGTYPE *
%{ $input = (void *) $1; %}

%typemap(directorin) SWIGTYPE &
%{ $input = ($1_ltype) &$1; %}

// Pointer to a class member 
%typemap(out) SWIGTYPE (CLASS::*) 
%{ *($&1_ltype)$result =$1; %}

%typemap(out) SWIGTYPE *const&
%{ $result = (void *)*$1; %}

// Function pointers
%typemap(out) SWIGTYPE ((*)(ANY))
%{ $result = (void *)$1; %}

%typemap(out) SWIGTYPE *&
%{ $result = (void *)*$1; %} 

/* 
 * OBJCTYPE TYPEMAPS: Represents the ObjectiveC(proxy) type corresponding to each ObjectiveC++ type in the intermediate(wrapper) layer. 
 */
// Primary types
%typemap(objctype)  bool, const bool &                      "BOOL"
%typemap(objctype)  char, const char &                      "char"
%typemap(objctype)  signed char, const signed char &        "signed char"
%typemap(objctype)  unsigned char, const unsigned char &    "unsigned char"
%typemap(objctype)  short, const short &                    "short"
%typemap(objctype)  unsigned short, const unsigned short &  "unsigned short"
%typemap(objctype)  int, const int &                         "int"
%typemap(objctype)  unsigned int, const unsigned int &       "unsigned int"
%typemap(objctype)  long, const long &                       "long"
%typemap(objctype)  unsigned long, const unsigned long &     "unsigned long"
%typemap(objctype)  long long, const long long &             "long long"
%typemap(objctype)  unsigned long long, const unsigned long long & "unsigned long long"
%typemap(objctype)  float, const float &                     "float"
%typemap(objctype)  double, const double &                   "double"
%typemap(objctype)  void                                     "void"

// References will always be treated as pointers in the proxy layer (ObjectiveC)
%typemap(objctype) bool &                  "BOOL *"
%typemap(objctype) char &                  "char *"
%typemap(objctype) signed char &           "signed char *"
%typemap(objctype) unsigned char &         "unsigned char *"
%typemap(objctype) short &                 "short *"
%typemap(objctype) unsigned short &        "unsigned short *"
%typemap(objctype) int &                   "int *"
%typemap(objctype) unsigned int &          "unsigned int *"
%typemap(objctype) long &                  "long *"
%typemap(objctype) unsigned long &         "unsigned long  *"
%typemap(objctype) long long &             "long long *"
%typemap(objctype) unsigned long long &    "unsigned long long  *"
%typemap(objctype) float &                 "float *"
%typemap(objctype) double &                "double *"

// C strings:
%typemap(objctype) char *, const char *, char *&, char[ANY], char[]    "NSString *"

// Objects will always be treated as pointers in ObjectiveC
%typemap(objctype) SWIGTYPE                             "$objcclassname*"
%typemap(objcbasetype) SWIGTYPE                         "$objcclassname_stripped"

// C/C++ Pointers to primitive types are treated as is
// C/C++ prinitve pointers are treated as is in ObjectiveC++
// References to primitive types are treated as pointers in the wrapper(ObjectiveC++) layer.
%typemap(objctype) const bool *,              bool *                  "BOOL *"
%typemap(objctype) const signed char *, 		signed char *           "signed char *"
%typemap(objctype) const unsigned char *, 	unsigned char *         "unsigned char *"
%typemap(objctype) const short *,				short *                 "short *"
%typemap(objctype) const unsigned short *,	unsigned short *        "unsigned short *"
%typemap(objctype) const int *,		    	int *                   "int *"
%typemap(objctype) const unsigned int *,		unsigned int *          "unsigned int *"
%typemap(objctype) const long *,				long *                  "long *"
%typemap(objctype) const unsigned long *, 	unsigned long *         "unsigned long  *"
%typemap(objctype) const long long *, 		long long *             "long long *"
%typemap(objctype) const unsigned long long *,unsigned long long *    "unsigned long long  *"
%typemap(objctype) const float *, 			float *                 "float *"
%typemap(objctype) const double *,  			double *                "double *"
%typemap(objctype) const void *,                        void *                  "void *"

// C/C++ Pointers are treated as  as pointers in ObjectiveC
%typemap(objctype) SWIGTYPE *                           "$objcclassname*" 
%typemap(objcbasetype) SWIGTYPE *                       "$objcclassname_stripped"

// Arrays to non-primitive types
%typemap(objctype) SWIGTYPE []                          "$objcclassname*"

// Pointer to a class member
%typemap(objctype) SWIGTYPE (CLASS::*)                  "$objcclassname*"  

// References to non-primitive types
%typemap(objctype) SWIGTYPE &                           "$objcclassname*"
%typemap(objctype) SWIGTYPE *const&                     "$objcclassname*"
%typemap(objcbasetype) SWIGTYPE &                       "$objcclassname_stripped"

// Function pointers
%typemap(objctype) SWIGTYPE ((*)(ANY))                  "$objcclassname*"


/* 
 * OBJCIN TYPEMAPS: Used for "in" arguments type conversions from ObjectiveC(proxy) layer to ObjectiveC++(wrapper) layer.
 */

// Primary types
%typemap(objcin) bool, const bool &,
	     char, const char &,
             signed char, const signed char &,
             unsigned char, const unsigned char &,
             short, const short &,
             unsigned short, const unsigned short &,
             int, const int &,
             unsigned int, const unsigned int &,
             long, const long &,
             unsigned long, const unsigned long &,
             long long, const long long &,
             unsigned long long, const unsigned long long &,
             float, const float &,
             double, const double &
"$objcinput"

// No "objcin" for void
%typemap(objcin) void ""

// References: are treated as pointers in the proxy layer (ObjectiveC)
%typemap(objcin) bool &, 
                 char &,
	     	 signed char &,
	         unsigned char &,
		 short &,
		 unsigned short &,
		 int &,
		 unsigned int &,
		 long &,
		 unsigned long &,
		 long long &,
		 unsigned long long &,
		 float &,
		 double &
"$objcinput"

// C/C++ pointers to primitive types are treated as is in the Proxy layer.
%typemap(objcin) const bool *,                  bool *,
                 const char *,  		char *,
	     	 const signed char *, 		signed char *,
	         const unsigned char *, 	unsigned char *,
		 const short *,			short *,
		 const unsigned short *,	unsigned short *,
		 const int *,		    	int *,
		 const unsigned int *,		unsigned int *,
		 const long *,			long &,
	     	 const unsigned long *, 	unsigned long &,
	     	 const long long *, 		long long *,
	     	 const unsigned long long *,unsigned long long *,
	      	 const float *, 		float *,
	      	 const double *,  		double *,
	      	 const void *,                  void *
"$objcinput"

//C strings:
%typemap(objcin) char *, char[ANY], char[]  "$objcinput"
%typemap(objcin) char *&                    "$objcinput"

// Objects passed by value: Convert from an ObjectiveC pointer to the ObjectiveC++ void* pointer.
%typemap(objcin) SWIGTYPE "[$objcinput getCptr]"

// C/C++ Pointers, primary and object, are exported as ObjectiveC pointers
%typemap(objcin) SWIGTYPE *, SWIGTYPE & "[$objcinput getCptr]"
%typemap(objcin) SWIGTYPE "[$objcinput getCptr]"

// Pointer to a class member will be passed as void*, convert appropriately
%typemap(objcin) SWIGTYPE (CLASS::*) "[$objcinput getCptr]" 

%typemap(objcin) SWIGTYPE *const& "[$objcinput getCptr]" 

/*
 * OBJCOUT TYPEMAPS: Used for return-type type conversions: ObjectiveC++(wrapper) to ObjectiveC(proxy)
 */

// Primary types are exported as ObjectiveC primary types
%typemap(objcout) bool, const bool &,
	      char, const char &,
	      signed char, const signed char &,
	      unsigned char, const unsigned char &,
	      short, const short &,
	      unsigned short, const unsigned short &,
	      int, const int &,
	      unsigned int, const unsigned int &,
	      long, const long &,
	      unsigned long, const unsigned long &,
	      long long, const long long &,
	      unsigned long long, const unsigned long &,
	      float, const float &,
	      double, const double &
%{   return $imcall; %}

%typemap(objcout) void "   $imcall;"

%typemap(objcout) bool &,
		  char &,
		  signed char &,
	 	  unsigned char &,
		  short &,
		  unsigned short &,
		  int &,
		  unsigned int &,
		  long &,
		  unsigned long &,
		  long long &,
		  unsigned long long &,
		  float &,
		  double &
%{   return $imcall; %}

%typemap(objcout) const bool *,              bool *,
             	  const char *,  			char *,
	     	  const signed char *, 		signed char *,
	          const unsigned char *, 	unsigned char *,
		  const short *,				short *,
		  const unsigned short *,	unsigned short *,
		  const int *,		    	int *,
		  const unsigned int *,		unsigned int *,
		  const long *,				long *,
	     	  const unsigned long *, 	unsigned long *,
	     	  const long long *, 		long long *,
	     	  const unsigned long long *,unsigned long long *,
	      	  const float *, 			float *,
	      	  const double *,  			double *,
	      	  const void *,                          void *
%{   return $imcall; %}

// C strings: 
%typemap(objcout)const char *,char * 
%{   NSString *ret = $imcall;
    return ret; %}

%typemap(objcout) char *& 
%{   NSString *ret = $imcall;
	return ret; %}

%typemap(objcout) char[ANY], char[] 
%{   NSString *ret = $imcall;
	return ret; %}

// Objects returned by value: Convert the void* pointer to the ObjectiveC pointer.
// Returned C++ pointers will have to be deleted by the client directly.
// As such, we mark swigOwnCObject as YES. This has to be reviewed again.
%typemap(objcout) SWIGTYPE
%{   void* cPtr = $imcall;
	$objcclassname* ret = nil;
	if(cPtr) {
		ret = [[$objcclassname alloc] initWithCptr:cPtr swigOwnCObject:YES];
	}
	return ret; %}

// Pointer and reference objects are returned as ObjectiveC pointers
// The returned C++ pointers will not have to be deleted by the client directly
// As such, we mark swigOwnCObject as NO.
%typemap(objcout) SWIGTYPE &
%{   void* cPtr = $imcall;
	$objcclassname* ret = nil;
	if(cPtr) {
		ret = [[$objcclassname alloc] initWithCptr:cPtr swigOwnCObject:NO];
	}
	return ret; %}
	
%typemap(objcout) SWIGTYPE *
%{   void* cPtr = $imcall;
	$objcclassname* ret = nil;
	if(cPtr) {
	ret = [[$objcclassname alloc] initWithCptr:cPtr swigOwnCObject:NO];
	}
	return ret; %}

// C function pointer
%typemap(objcout) SWIGTYPE ((*)(ANY)) 
%{   void* cPtr = $imcall;
	$objcclassname* ret = nil;
	if(cPtr) {
		ret = [[$objcclassname alloc] initWithCptr:cPtr swigOwnCObject:NO];
	}
	return ret; %}

%typemap(objcvarout) SWIGTYPE ((*)(ANY)) 
%{ $objcclassname* $objcvarname = [[$objcclassname alloc] initWithCptr:($imcall) swigOwnCObject:NO]; %}

// Pointer to a class member will be returned as id
%typemap(objcout) SWIGTYPE (CLASS::*) 
%{   void* cPtr = $imcall;
	$objcclassname* ret = nil;
	if(cPtr) {
		ret = [[$objcclassname alloc] initWithCptr:cPtr swigOwnCObject:NO];
	}
	return ret; %}

%typemap(objcout) SWIGTYPE *const& 
%{   void* cPtr = $imcall;
	$objcclassname* ret = nil;
	if(cPtr) {
		ret = [[$objcclassname alloc] initWithCptr:cPtr swigOwnCObject:NO];
	}
	return ret; %}
 
/* apply typemaps */
// Treat references to arrays like like references to a single element.
%apply SWIGTYPE & { SWIGTYPE ((&)[ANY]) }
%apply unsigned long { size_t };
%apply const unsigned long & { const size_t & };

/* const pointers */
%apply SWIGTYPE * { SWIGTYPE *const }

/* Exception handling */
 
%typemap(throws) int, 
                 long, 
                 short, 
                 unsigned int, 
                 unsigned long, 
                 unsigned short
%{   char error_msg[256];
	sprintf(error_msg, "C++ $1_type exception thrown, value: %d", $1);
	SWIG_ObjcThrowException(SWIG_ObjcRuntimeException, error_msg);
	return $null; %}
 
%typemap(throws) SWIGTYPE, SWIGTYPE &, SWIGTYPE *, SWIGTYPE [], SWIGTYPE [ANY]
%{   (void)$1;
	SWIG_ObjcThrowException(SWIG_ObjcRuntimeException, "C++ $1_type exception thrown");
	return $null; %}

%typemap(throws) char *
%{   SWIG_ObjcThrowException(SWIG_ObjcRuntimeException, $1);
	return $null; %}


#define %objcexception(exceptionclasses) %feature("except",throws=exceptionclasses)
#define %noobjcexception            %feature("except","0",throws="")
#define %clearobjcexception         %feature("except","",throws="")

/* Additional typemaps */
// Typemaps containing ObjectiveC code used when generating ObjectiveC proxy classes.
%include <objcproxycode.swg>

// Typemaps for handling enums
%include <objcenums.swg>

// ObjectiveC runtime support code.
%include <objcruntime.swg>

// List of all reserved ObjectiveC keywords.
%include <objckw.swg>
