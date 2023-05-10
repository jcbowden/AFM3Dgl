unit GeometryTypes;

interface

type
  Float = Single;

  TScalarf = Float;
  TScalard = Double;

  TAnglef = Float;
  TAngled = Double;

// *****************************************************************************
// TVector2x:
// *****************************************************************************

type
  TVector2i = array [0..1] of Integer;
  TVector2f = array [0..1] of Float;
  TVector2d = array [0..1] of Double;
  TVector2p = array [0..1] of Pointer;
const
  NullVector2i : TVector2i = (0,0);
  NullVector2f : TVector2f = (0,0);
  NullVector2d : TVector2d = (0,0);
  NullVector2p : TVector2p = (nil,nil);
  XVector2i : TVector2i = (1,0);
  XVector2f : TVector2f = (1,0);
  XVector2d : TVector2d = (1,0);
  YVector2i : TVector2i = (0,1);
  YVector2f : TVector2f = (0,1);
  YVector2d : TVector2d = (0,1);

// *****************************************************************************
// TVector3x:
// *****************************************************************************

type
  TVector3i = array [0..2] of Integer;
  TVector3f = array [0..2] of Float;
  TVector3d = array [0..2] of Double;
  TVector3p = array [0..2] of Pointer;
const
  NullVector3i : TVector3i = (0,0,0);
  NullVector3f : TVector3f = (0,0,0);
  NullVector3d : TVector3d = (0,0,0);
  NullVector3p : TVector3p = (nil,nil,nil);
  XVector3i : TVector3i = (1,0,0);
  XVector3f : TVector3f = (1,0,0);
  XVector3d : TVector3d = (1,0,0);
  YVector3i : TVector3i = (0,1,0);
  YVector3f : TVector3f = (0,1,0);
  YVector3d : TVector3d = (0,1,0);
  ZVector3i : TVector3i = (0,0,1);
  ZVector3f : TVector3f = (0,0,1);
  ZVector3d : TVector3d = (0,0,1);

// *****************************************************************************
// TVector4x:
// *****************************************************************************

type
  TVector4i = array [0..3] of Integer;
  TVector4f = array [0..3] of Float;
  TVector4d = array [0..3] of Double;
  TVector4p = array [0..3] of Pointer;
const
  NullVector4i : TVector4i = (0,0,0,0);
  NullVector4f : TVector4f = (0,0,0,0);
  NullVector4d : TVector4d = (0,0,0,0);
  NullVector4p : TVector4p = (nil,nil,nil,nil);


// *****************************************************************************
// TMatrix2x:
// *****************************************************************************

type
  TMatrix2i = array [0..1,0..1] of Integer;
  TMatrix2f = array [0..1,0..1] of Float;
  TMatrix2d = array [0..1,0..1] of Double;
const
  NullMatrix2i : TMatrix2i = (
    (0,0),
    (0,0)
  );
  IdentityMatrix2i : TMatrix2i = (
    (1,0),
    (0,1)
  );

  NullMatrix2f : TMatrix2f = (
    (0,0),
    (0,0)
  );
  IdentityMatrix2f : TMatrix2f = (
    (1,0),
    (0,1)
  );

  NullMatrix2d : TMatrix2d = (
    (0,0),
    (0,0)
  );
  IdentityMatrix2d : TMatrix2d = (
    (1,0),
    (0,1)
  );

// *****************************************************************************
// TMatrix3x:
// *****************************************************************************

type
  TMatrix3i = array [0..2,0..2] of Integer;
  TMatrix3f = array [0..2,0..2] of Float;
  TMatrix3d = array [0..2,0..2] of Double;
const
  NullMatrix3i : TMatrix3i = (
    (0,0,0),
    (0,0,0),
    (0,0,0)
  );
  IdentityMatrix3i : TMatrix3i = (
    (1,0,0),
    (0,1,0),
    (0,0,1)
  );

  NullMatrix3f : TMatrix3f = (
    (0,0,0),
    (0,0,0),
    (0,0,0)
  );
  IdentityMatrix3f : TMatrix3f = (
    (1,0,0),
    (0,1,0),
    (0,0,1)
  );

  NullMatrix3d : TMatrix3d = (
    (0,0,0),
    (0,0,0),
    (0,0,0)
  );
  IdentityMatrix3d : TMatrix3d = (
    (1,0,0),
    (0,1,0),
    (0,0,1)
  );

// *****************************************************************************
// TMatrix4x:
// *****************************************************************************
  
type
  TMatrix4i = array [0..3,0..3] of Integer;
  TMatrix4f = array [0..3,0..3] of Float;
  TMatrix4d = array [0..3,0..3] of Double;
const
  NullMatrix4i : TMatrix4i = (
    (0,0,0,0),
    (0,0,0,0),
    (0,0,0,0),
    (0,0,0,0)
  );
  IdentityMatrix4i : TMatrix4i = (
    (1,0,0,0),
    (0,1,0,0),
    (0,0,1,0),
    (0,0,0,1)
  );

  NullMatrix4f : TMatrix4f = (
    (0,0,0,0),
    (0,0,0,0),
    (0,0,0,0),
    (0,0,0,0)
  );
  IdentityMatrix4f : TMatrix4f = (
    (1,0,0,0),
    (0,1,0,0),
    (0,0,1,0),
    (0,0,0,1)
  );

  NullMatrix4d : TMatrix4d = (
    (0,0,0,0),
    (0,0,0,0),
    (0,0,0,0),
    (0,0,0,0)
  );
  IdentityMatrix4d : TMatrix4d = (
    (1,0,0,0),
    (0,1,0,0),
    (0,0,1,0),
    (0,0,0,1)
  );

// *****************************************************************************
// TPointXy:
// *****************************************************************************

type
  TPoint2i = TVector2i;
  TPoint2f = TVector2f;
  TPoint2d = TVector2d;
  TPoint3i = TVector3i;
  TPoint3f = TVector3f;
  TPoint3d = TVector3d;
  TPoint4i = TVector4i;
  TPoint4f = TVector4f;
  TPoint4d = TVector4d;
  
// *****************************************************************************
// TColorXy:
// *****************************************************************************

type
  TColor3b = array [0..2] of Byte;
  TColor3w = array [0..2] of Word;
  TColor3f = array [0..2] of Float;

const
  BlackColor3b : TColor3b = (0,0,0);
  BlackColor3w : TColor3w = (0,0,0);
  BlackColor3f : TColor3f = (0,0,0);
  WhiteColor3b : TColor3b = ($ff,$ff,$ff);
  WhiteColor3w : TColor3w = ($ffff,$ffff,$ffff);
  WhiteColor3f : TColor3f = (1,1,1);

type
  TColor4b = array [0..3] of Byte;
  TColor4w = array [0..3] of Word;
  TColor4f = array [0..3] of Float;

const
  BlackColor4b : TColor4b = (0,0,0,$ff);
  BlackColor4w : TColor4w = (0,0,0,$ffff);
  BlackColor4f : TColor4f = (0,0,0,1);
  TransparentColor4b : TColor4b = (0,0,0,0);
  TransparentColor4w : TColor4w = (0,0,0,0);
  TransparentColor4f : TColor4f = (0,0,0,0);
  WhiteColor4b : TColor4b = ($ff,$ff,$ff,$ff);
  WhiteColor4w : TColor4w = ($ffff,$ffff,$ffff,$ffff);
  WhiteColor4f : TColor4f = (1,1,1,1);
  // The default OpenGL lighting values:
  DefaultAmbientColor4b : TColor4b = (51,51,51,255);
  DefaultAmbientColor4w : TColor4w = (13107,13107,13107,65535);
  DefaultAmbientColor4f : TColor4f = (0.2,0.2,0.2,1.0);
  DefaultDiffuseColor4b : TColor4b = (204,204,204,255);
  DefaultDiffuseColor4w : TColor4w = (52428,52428,52428,65535);
  DefaultDiffuseColor4f : TColor4f = (0.8,0.8,0.8,1.0);










type
  TAVector2f = TVector2f;
  TAVector2d = TVector2d;

type
  TAVector3f = TVector3f;
  TAVector3d = TVector3d;
  THVector3f = TVector3f;
  THVector3d = TVector3d;
const
  NullHVector3f : THVector3f = (0,0,1);
  NullHVector3d : THVector3d = (0,0,1);
  XHVector3f : THVector3f = (1,0,1);
  XHVector3d : THVector3d = (1,0,1);
  YHVector3f : THVector3f = (0,1,1);
  YHVector3d : THVector3d = (0,1,1);

type
  TAVector4f = TVector4f;
  TAVector4d = TVector4d;
  THVector4f = TVector4f;
  THVector4d = TVector4d;
const
  NullHVector4f : THVector4f = (0,0,0,1);
  NullHVector4d : THVector4d = (0,0,0,1);
  XHVector4f : THVector4f = (1,0,0,1);
  XHVector4d : THVector4d = (1,0,0,1);
  YHVector4f : THVector4f = (0,1,0,1);
  YHVector4d : THVector4d = (0,1,0,1);
  ZHVector4f : THVector4f = (0,0,1,1);
  ZHVector4d : THVector4d = (0,0,1,1);

type
  TAPoint2f = TAVector2f;
  TAPoint2d = TAVector2d;
  TAPoint3f = TAVector3f;
  TAPoint3d = TAVector3d;
  THPoint3f = THVector3f;
  THPoint3d = THVector3d;
  THPoint4f = THVector4f;
  THPoint4d = THVector4d;

implementation

end.
