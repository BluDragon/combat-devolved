/* Geometrically finds the intersection of two lines and caches the results (in the DLL)
**
** argument0 = x position of a point on the first line
** argument1 = y position of a point on the first line
** argument2 = angle of the first line (degrees)
** argument3 = x position of a point on the 2nd line
** argument4 = y position of a point on the 2nd line
** argument5 = angle of the 2nd line (degrees)
**
** Returns 0 on OK, non-zero on error
**
** Call getLineInterceptX and getLineInterceptY to retrieve the cached results
*/

return external_call(global.dll_H2DFindLineIntersection, argument0, argument1, argument2, argument3, argument4, argument5);
