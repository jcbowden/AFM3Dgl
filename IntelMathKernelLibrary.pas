// efg's Computer Lab, www.efg2.com/lab
// efg, February 1999

UNIT IntelMathKernelLibrary;

INTERFACE

  TYPE
    TSingleComplex =
    RECORD
      x:  Single;
      y:  Single
    END;

    TDoubleComplex =
    RECORD
      x:  Double;
      y:  Double
    END;

  FUNCTION SetSingleComplex(CONST x,y:  Single):  TSingleComplex;
  FUNCTION SetDoubleComplex(CONST x,y:  Double):  TDoubleComplex;

  // Main 'trick' so far:  Use all VAR parameters (i.e., a pointer is being
  // passed).  For vectors pass first element, i.e., pass x[1] instead of
  // simply x.  Could define arrays to be 0 or 1-based this way.

  // BLAS Level 1 /////////////////////////////////////////////////////////////

  // ?asum -- Computes the sum of magnitudes of the vector elements
  FUNCTION sasum  (VAR n   :  INTEGER;                        // Single
                   VAR x   :  Single;          // vector
                   VAR incx:  INTEGER):  Single;   CDecl;

  FUNCTION dasum  (VAR n   :  INTEGER;                        // Double
                   VAR x   :  Double;          // vector
                   VAR incx:  INTEGER):  Single;   CDecl;

  FUNCTION scasum (VAR n   :  INTEGER;                        // Complex Single
                   VAR x   :  TSingleComplex;  // vector
                   VAR incx:  INTEGER):  Single;   CDecl;

  FUNCTION dzasum (VAR n   :  INTEGER;                        // Complex Double
                   VAR x   :  TDoubleComplex;  // vector
                   VAR incx:  INTEGER):  Single;   CDecl;


  PROCEDURE scopy (VAR n   :  INTEGER;
                   VAR x   :  Single;    // vector
                   VAR incx:  INTEGER;
                   VAR y   :  Single;    // vector
                   VAR incy:  INTEGER);            CDecl;


  FUNCTION sdot   (VAR n   :  INTEGER;
                   VAR x   :  Single;    // vector
                   VAR incx:  INTEGER;
                   VAR y   :  Single;    // vector
                   VAR incy:  INTEGER):  Single;   CDecl;

  FUNCTION snrm2   (VAR n   :  INTEGER;
                   VAR x   :  Single;    // vector
                   VAR incx:  INTEGER):  Single;   CDecl;


  // BLAS Level 2 /////////////////////////////////////////////////////////////

 { PROCEDURE sger  (VAR m,n  :  INTEGER;
                   VAR alpha:  Single;
                   VAR x    :  Single;    // m-element vector
                   VAR incx :  INTEGER;
                   VAR y    :  Single;    // n-element vector
                   VAR incy :  INTEGER;
                   VAR a    :  Single;    // m-by-n matrix
                   VAR lda  :  INTEGER);            CDecl;         }

IMPLEMENTATION

  USES
    Windows,   // THandle
    Dialogs,   // MessageDlg
    SysUtils;  // IntToHex

  CONST
    IntelDLL = 'mkl_II.dll';

  VAR
    DLLHandle:  THandle;


  FUNCTION SetSingleComplex(CONST x,y:  Single):  TSingleComplex;
  BEGIN
    RESULT.x := x;
    RESULT.y := y
  END {SetSingleComplex};


  FUNCTION SetDoubleComplex(CONST x,y:  Double):  TDoubleComplex;
  BEGIN
    RESULT.x := x;
    RESULT.y := y
  END {SetDoubleComplex};


  // 'Strange' Intel names were discovered by viewing the DLL in the KEdit
  // editor, but I didn't believe the names were correct until the TDUMP
  // utility also verified the 'strange' prefix, which I assume is present
  // to guarantee a unique name.

  // BLAS Level 1 /////////////////////////////////////////////////////////////

  // ?asum -- Computes the sum of magnitudes of the vector elements
{  FUNCTION  sasum;   CDecl;   EXTERNAL IntelDLL NAME '___?MKL_DLL?_sasum';
  FUNCTION  dasum;   CDecl;   EXTERNAL IntelDLL NAME '___?MKL_DLL?_dasum';
  FUNCTION  scasum;  CDecl;   EXTERNAL IntelDLL NAME '___?MKL_DLL?_scasum';
  FUNCTION  dzasum;  CDecl;   EXTERNAL IntelDLL NAME '___?MKL_DLL?_dzasum';

  PROCEDURE scopy;   CDecl;   EXTERNAL IntelDLL NAME '___?MKL_DLL?_scopy';
  FUNCTION  sdot;    CDecl;   EXTERNAL IntelDLL NAME '___?MKL_DLL?_sdot';  }

   FUNCTION  sasum;   CDecl;   EXTERNAL IntelDLL NAME 'sasum';
  FUNCTION  dasum;   CDecl;   EXTERNAL IntelDLL NAME 'dasum';
  FUNCTION  scasum;  CDecl;   EXTERNAL IntelDLL NAME 'scasum';
  FUNCTION  dzasum;  CDecl;   EXTERNAL IntelDLL NAME 'dzasum';

  PROCEDURE scopy;   CDecl;   EXTERNAL IntelDLL NAME 'scopy';
  FUNCTION  sdot;    CDecl;   EXTERNAL IntelDLL NAME 'sdot';
  FUNCTION  snrm2;    CDecl;   EXTERNAL IntelDLL NAME 'snrm2';
 // BLAS Level 2 /////////////////////////////////////////////////////////////

{  PROCEDURE sger;  CDecl;   EXTERNAL IntelDLL NAME '___?MKL_DLL?_sger';       }

INITIALIZATION
  DLLHandle := LoadLibrary(IntelDLL);
  IF   DLLHandle = NULL
  THEN MessageDlg('Error Loading ' + IntelDLL + #$0D + '(Error Code ' +
                  IntToHex(GetLastError,8) + ')', mtError, [mbOK], 0)

FINALIZATION
  IF   NOT FreeLibrary(DLLHandle)
  THEN MessageDlg('Error Freeing ' + IntelDLL + #$0D + '(Error Code ' +
                  IntToHex(GetLastError,8) + ')', mtError, [mbOK], 0)
END.
