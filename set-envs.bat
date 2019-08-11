SET THISDIR=%~dp0

REM 
REM Customize the follwing lines.
REM 

IF "%BUILDPLATFORM%" == "" (
	IF "%PROCESSOR_ARCHITECTURE%" EQU "AMD64" SET BUILDPLATFORM=x64
	IF "%PROCESSOR_ARCHITECTURE%" EQU "x86"   SET BUILDPLATFORM=x86
)
SET RDKITDIR=%THISDIR%rdkit-Release_2019_03_3
SET BOOSTDIR=%THISDIR%boost_1_70_0
SET EIGENDIR=%THISDIR%eigen-eigen-323c052e1731
SET ZLIBDIR=%THISDIR%zlib-1.2.11
IF "%PYTHONDIR%" == "" (
	IF "%BUILDPLATFORM%" EQU "x64" SET PYTHONDIR=%LOCALAPPDATA%\Programs\Python\Python36
	IF "%BUILDPLATFORM%" EQU "x86" SET PYTHONDIR=%LOCALAPPDATA%\Programs\Python\Python36-32
)	

REM 
REM Customize the above lines.
REM 

IF "%BUILDPLATFORM%" == "x64" (
	SET CMAKEG=Visual Studio 15 2017 Win64
	SET MSBUILDPLATFORM=x64
	SET ADDRESSMODEL=64
) ELSE IF "%BUILDPLATFORM%" == "x86" (
	SET CMAKEG=Visual Studio 15 2017
	SET MSBUILDPLATFORM=Win32
	SET ADDRESSMODEL=32
) ELSE (
	ECHO Error: Unknown platform "%BUILDPLATFORM%".
	EXIT
)

SET BUILDDIR=build%BUILDPLATFORM%

IF "%PYTHONDIR%" EQU "" (
	ECHO Error: PYTHONDIR is not specified.
	EXIT
) 

IF "%__PythonPathAdded%" NEQ "" GOTO :L__PythonPathAdded
	PATH %PYTHONDIR%;%Path%
	SET __PythonPathAdded=1
:L__PythonPathAdded

PUSHD %PYTHONDIR%
.\Scripts\pip install numpy
REM Some tests requires pandas and pillows.
.\Scripts\pip install pandas
.\Scripts\pip install pillow
POPD

:END
