//----- (10004C60) --------------------------------------------------------
bool __cdecl sub_10004C60(char a1)
{
  v1("unmountAll", L"unmountAll");
  v2("unmount", L"unmount");
  v3("mount", L"mount");
  v4("getDomains", L"getDomains");
  v5(v107, L"getHashes");
  v6(v109, L"getFile");
  v7(v111, L"setFile");
  v8(v112, L"assignFiles");
  v9(v104, L"entryFiles");
  v10(v100, L"clearFiles");
  v11(v106, L"assignDomain");
  v12(v98, L"entryDomain");
  v13(v108, L"clearDomain");
  v14(v102, L"clearAll");
  v15(v110, L"pathHash");
  v16(v97, L"fileHash");
  v17("CompoundStorageMedia", L"CompoundStorageMedia");
  v18("Storages", L"Storages");
  v73 = a1;
  LOBYTE(v113) = 0x11;
  v72 = &SimpleBinder::Detail::BindUtil::`vftable';
  v74 = 0;
  v76 = 0;
  v75 = sub_10006250((int)"Storages", 0);
  LOBYTE(v113) = 0x12;
  v19 = sub_10001500((int)&v72, (int)"CompoundStorageMedia", &v77, (int *)&v94);
  v20 = *(_DWORD *)(v19 + 8);
  if ( v20 )
  {
    if ( *(_BYTE *)(v19 + 4) )
      v21 = sub_10001E80(v20, (int)v97, &v91, *(_DWORD *)(v19 + 0xC));
    else
      v21 = sub_10007590(v20, (int)v97);
    *(_BYTE *)(v19 + 5) |= v21 == 0;
  }
  v22 = *(_DWORD *)(v19 + 8);
  if ( v22 )
  {
    if ( *(_BYTE *)(v19 + 4) )
      v23 = sub_10001E80(v22, (int)v110, &v83, *(_DWORD *)(v19 + 0xC));
    else
      v23 = sub_10007590(v22, (int)v110);
    *(_BYTE *)(v19 + 5) |= v23 == 0;
  }
  v24 = *(_DWORD *)(v19 + 8);
  if ( v24 )
  {
    if ( *(_BYTE *)(v19 + 4) )
      v25 = sub_10001FC0(v24, (int)v102, &v89, *(_DWORD *)(v19 + 0xC));
    else
      v25 = sub_10007590(v24, (int)v102);
    *(_BYTE *)(v19 + 5) |= v25 == 0;
  }
  v26 = *(_DWORD *)(v19 + 8);
  if ( v26 )
  {
    if ( *(_BYTE *)(v19 + 4) )
      v27 = sub_10001E80(v26, (int)v108, &v79, *(_DWORD *)(v19 + 0xC));
    else
      v27 = sub_10007590(v26, (int)v108);
    *(_BYTE *)(v19 + 5) |= v27 == 0;
  }
  v28 = *(_DWORD *)(v19 + 8);
  if ( v28 )
  {
    if ( *(_BYTE *)(v19 + 4) )
      v29 = sub_10001DE0(v28, (int)v98, &v87, *(_DWORD *)(v19 + 0xC));
    else
      v29 = sub_10007590(v28, (int)v98);
    *(_BYTE *)(v19 + 5) |= v29 == 0;
  }
  v30 = *(_DWORD *)(v19 + 8);
  if ( v30 )
  {
    if ( *(_BYTE *)(v19 + 4) )
      v31 = sub_10001DE0(v30, (int)v106, &v81, *(_DWORD *)(v19 + 0xC));
    else
      v31 = sub_10007590(v30, (int)v106);
    *(_BYTE *)(v19 + 5) |= v31 == 0;
  }
  v32 = *(_DWORD *)(v19 + 8);
  if ( v32 )
  {
    if ( *(_BYTE *)(v19 + 4) )
      v33 = sub_10001DE0(v32, (int)v100, &v85, *(_DWORD *)(v19 + 0xC));
    else
      v33 = sub_10007590(v32, (int)v100);
    *(_BYTE *)(v19 + 5) |= v33 == 0;
  }
  v34 = *(_DWORD *)(v19 + 8);
  if ( v34 )
  {
    if ( *(_BYTE *)(v19 + 4) )
      v35 = sub_10001D40(v34, (int)v104, &v93, *(_DWORD *)(v19 + 0xC));
    else
      v35 = sub_10007590(v34, (int)v104);
    *(_BYTE *)(v19 + 5) |= v35 == 0;
  }
  v36 = *(_DWORD *)(v19 + 8);
  if ( v36 )
  {
    if ( *(_BYTE *)(v19 + 4) )
      v37 = sub_10001CA0(v36, (int)v112, &v92, *(_DWORD *)(v19 + 0xC));
    else
      v37 = sub_10007590(v36, (int)v112);
    *(_BYTE *)(v19 + 5) |= v37 == 0;
  }
  v38 = *(_DWORD *)(v19 + 8);
  if ( v38 )
  {
    if ( *(_BYTE *)(v19 + 4) )
      v39 = sub_10001CA0(v38, (int)v111, &v90, *(_DWORD *)(v19 + 0xC));
    else
      v39 = sub_10007590(v38, (int)v111);
    *(_BYTE *)(v19 + 5) |= v39 == 0;
  }
  v40 = *(_DWORD *)(v19 + 8);
  if ( v40 )
  {
    if ( *(_BYTE *)(v19 + 4) )
      v41 = sub_10001D40(v40, (int)v109, &v88, *(_DWORD *)(v19 + 0xC));
    else
      v41 = sub_10007590(v40, (int)v109);
    *(_BYTE *)(v19 + 5) |= v41 == 0;
  }
  v42 = *(_DWORD *)(v19 + 8);
  if ( v42 )
  {
    if ( *(_BYTE *)(v19 + 4) )
      v43 = sub_10001F20(v42, (int)v107, &v86, *(_DWORD *)(v19 + 0xC));
    else
      v43 = sub_10007590(v42, (int)v107);
    *(_BYTE *)(v19 + 5) |= v43 == 0;
  }
  v44 = *(_DWORD *)(v19 + 8);
  if ( v44 )
  {
    if ( *(_BYTE *)(v19 + 4) )
      v45 = sub_10001FC0(v44, (int)"getDomains", &v84, *(_DWORD *)(v19 + 0xC));
    else
      v45 = sub_10007590(v44, (int)"getDomains");
    *(_BYTE *)(v19 + 5) |= v45 == 0;
  }
  v46 = *(_DWORD *)(v19 + 8);
  if ( v46 )
  {
    if ( *(_BYTE *)(v19 + 4) )
      v47 = sub_10001DE0(v46, (int)"mount", &v82, *(_DWORD *)(v19 + 0xC));
    else
      v47 = sub_10007590(v46, (int)"mount");
    *(_BYTE *)(v19 + 5) |= v47 == 0;
  }
  v48 = *(_DWORD *)(v19 + 8);
  if ( v48 )
  {
    if ( *(_BYTE *)(v19 + 4) )
      v49 = sub_10001E80(v48, (int)"unmount", &v80, *(_DWORD *)(v19 + 0xC));
    else
      v49 = sub_10007590(v48, (int)"unmount");
    *(_BYTE *)(v19 + 5) |= v49 == 0;
  }
  v50 = *(_DWORD *)(v19 + 8);
  if ( v50 )
  {
    if ( *(_BYTE *)(v19 + 4) )
      v51 = sub_10001FC0(v50, (int)"unmountAll", &v78, *(_DWORD *)(v19 + 0xC));
    else
      v51 = sub_10007590(v50, (int)"unmountAll");
    *(_BYTE *)(v19 + 5) |= v51 == 0;
  }
  v52 = (void (__stdcall *)(char *))dword_100AD0B0;
  v53 = *(_BYTE *)(v19 + 5) == 0;
  v72 = &SimpleBinder::Detail::BindUtil::`vftable';
  LOBYTE(v113) = 0x10;
  if ( !dword_100AD0B0 )
  {
    v52 = (void (__stdcall *)(char *))TVP_GetFunctionPtr((void (__stdcall *)(_DWORD))"tTJSString::~ tTJSString()");
    dword_100AD0B0 = (int)v52;
  }
  v52("Storages");
  v54 = (void (__stdcall *)(char *))dword_100AD0B0;
  LOBYTE(v113) = 0xF;
  if ( !dword_100AD0B0 )
  {
    v54 = (void (__stdcall *)(char *))TVP_GetFunctionPtr((void (__stdcall *)(_DWORD))"tTJSString::~ tTJSString()");
    dword_100AD0B0 = (int)v54;
  }
  v54("CompoundStorageMedia");
  v55 = (void (__stdcall *)(char *))dword_100AD0B0;
  LOBYTE(v113) = 0xE;
  if ( !dword_100AD0B0 )
  {
    v55 = (void (__stdcall *)(char *))TVP_GetFunctionPtr((void (__stdcall *)(_DWORD))"tTJSString::~ tTJSString()");
    dword_100AD0B0 = (int)v55;
  }
  v55(v97);
  v56 = (void (__stdcall *)(char *))dword_100AD0B0;
  LOBYTE(v113) = 0xD;
  if ( !dword_100AD0B0 )
  {
    v56 = (void (__stdcall *)(char *))TVP_GetFunctionPtr((void (__stdcall *)(_DWORD))"tTJSString::~ tTJSString()");
    dword_100AD0B0 = (int)v56;
  }
  v56(v110);
  v57 = (void (__stdcall *)(char *))dword_100AD0B0;
  LOBYTE(v113) = 0xC;
  if ( !dword_100AD0B0 )
  {
    v57 = (void (__stdcall *)(char *))TVP_GetFunctionPtr((void (__stdcall *)(_DWORD))"tTJSString::~ tTJSString()");
    dword_100AD0B0 = (int)v57;
  }
  v57(v102);
  v58 = (void (__stdcall *)(char *))dword_100AD0B0;
  LOBYTE(v113) = 0xB;
  if ( !dword_100AD0B0 )
  {
    v58 = (void (__stdcall *)(char *))TVP_GetFunctionPtr((void (__stdcall *)(_DWORD))"tTJSString::~ tTJSString()");
    dword_100AD0B0 = (int)v58;
  }
  v58(v108);
  v59 = (void (__stdcall *)(char *))dword_100AD0B0;
  LOBYTE(v113) = 0xA;
  if ( !dword_100AD0B0 )
  {
    v59 = (void (__stdcall *)(char *))TVP_GetFunctionPtr((void (__stdcall *)(_DWORD))"tTJSString::~ tTJSString()");
    dword_100AD0B0 = (int)v59;
  }
  v59(v98);
  v60 = (void (__stdcall *)(char *))dword_100AD0B0;
  LOBYTE(v113) = 9;
  if ( !dword_100AD0B0 )
  {
    v60 = (void (__stdcall *)(char *))TVP_GetFunctionPtr((void (__stdcall *)(_DWORD))"tTJSString::~ tTJSString()");
    dword_100AD0B0 = (int)v60;
  }
  v60(v106);
  v61 = (void (__stdcall *)(char *))dword_100AD0B0;
  LOBYTE(v113) = 8;
  if ( !dword_100AD0B0 )
  {
    v61 = (void (__stdcall *)(char *))TVP_GetFunctionPtr((void (__stdcall *)(_DWORD))"tTJSString::~ tTJSString()");
    dword_100AD0B0 = (int)v61;
  }
  v61(v100);
  v62 = (void (__stdcall *)(char *))dword_100AD0B0;
  LOBYTE(v113) = 7;
  if ( !dword_100AD0B0 )
  {
    v62 = (void (__stdcall *)(char *))TVP_GetFunctionPtr((void (__stdcall *)(_DWORD))"tTJSString::~ tTJSString()");
    dword_100AD0B0 = (int)v62;
  }
  v62(v104);
  v63 = (void (__stdcall *)(char *))dword_100AD0B0;
  LOBYTE(v113) = 6;
  if ( !dword_100AD0B0 )
  {
    v63 = (void (__stdcall *)(char *))TVP_GetFunctionPtr((void (__stdcall *)(_DWORD))"tTJSString::~ tTJSString()");
    dword_100AD0B0 = (int)v63;
  }
  v63(v112);
  v64 = (void (__stdcall *)(char *))dword_100AD0B0;
  LOBYTE(v113) = 5;
  if ( !dword_100AD0B0 )
  {
    v64 = (void (__stdcall *)(char *))TVP_GetFunctionPtr((void (__stdcall *)(_DWORD))"tTJSString::~ tTJSString()");
    dword_100AD0B0 = (int)v64;
  }
  v64(v111);
  v65 = (void (__stdcall *)(char *))dword_100AD0B0;
  LOBYTE(v113) = 4;
  if ( !dword_100AD0B0 )
  {
    v65 = (void (__stdcall *)(char *))TVP_GetFunctionPtr((void (__stdcall *)(_DWORD))"tTJSString::~ tTJSString()");
    dword_100AD0B0 = (int)v65;
  }
  v65(v109);
  v66 = (void (__stdcall *)(char *))dword_100AD0B0;
  LOBYTE(v113) = 3;
  if ( !dword_100AD0B0 )
  {
    v66 = (void (__stdcall *)(char *))TVP_GetFunctionPtr((void (__stdcall *)(_DWORD))"tTJSString::~ tTJSString()");
    dword_100AD0B0 = (int)v66;
  }
  v66(v107);
  v67 = (void (__stdcall *)(char *))dword_100AD0B0;
  LOBYTE(v113) = 2;
  if ( !dword_100AD0B0 )
  {
    v67 = (void (__stdcall *)(char *))TVP_GetFunctionPtr((void (__stdcall *)(_DWORD))"tTJSString::~ tTJSString()");
    dword_100AD0B0 = (int)v67;
  }
  v67("getDomains");
  v68 = (void (__stdcall *)(char *))dword_100AD0B0;
  LOBYTE(v113) = 1;
  if ( !dword_100AD0B0 )
  {
    v68 = (void (__stdcall *)(char *))TVP_GetFunctionPtr((void (__stdcall *)(_DWORD))"tTJSString::~ tTJSString()");
    dword_100AD0B0 = (int)v68;
  }
  v68("mount");
  v69 = (void (__stdcall *)(char *))dword_100AD0B0;
  LOBYTE(v113) = 0;
  if ( !dword_100AD0B0 )
  {
    v69 = (void (__stdcall *)(char *))TVP_GetFunctionPtr((void (__stdcall *)(_DWORD))"tTJSString::~ tTJSString()");
    dword_100AD0B0 = (int)v69;
  }
  v69("unmount");
  v70 = (void (__stdcall *)(char *))dword_100AD0B0;
  v113 = 0xFFFFFFFF;
  if ( !dword_100AD0B0 )
  {
    v70 = (void (__stdcall *)(char *))TVP_GetFunctionPtr((void (__stdcall *)(_DWORD))"tTJSString::~ tTJSString()");
    dword_100AD0B0 = (int)v70;
  }
  v70("unmountAll");
  return v53;
}
// 1008031C: using guessed type void *SimpleBinder::Detail::BindUtil::`vftable';
// 1008035C: using guessed type wchar_t aStorages[9];
// 10080370: using guessed type wchar_t aCompoundstorag[21];
// 1008039C: using guessed type wchar_t aFilehash[9];
// 100803B0: using guessed type wchar_t aPathhash[9];
// 100803C4: using guessed type wchar_t aClearall[9];
// 100803D8: using guessed type wchar_t aCleardomain[12];
// 100803F0: using guessed type wchar_t aEntrydomain[12];
// 10080408: using guessed type wchar_t aAssigndomain[13];
// 10080424: using guessed type wchar_t aClearfiles[11];
// 1008043C: using guessed type wchar_t aEntryfiles[11];
// 10080454: using guessed type wchar_t aAssignfiles[12];
// 1008046C: using guessed type wchar_t aSetfile[8];
// 1008047C: using guessed type wchar_t aGetfile[8];
// 1008048C: using guessed type wchar_t aGethashes[10];
// 100804A0: using guessed type wchar_t aGetdomains[11];
// 100804B8: using guessed type wchar_t aMount[6];
// 100804C4: using guessed type wchar_t aUnmount[8];
// 100804D4: using guessed type wchar_t aUnmountall[11];
// 100AD090: using guessed type int "tTJSString::tTJSString";
// 100AD0B0: using guessed type int dword_100AD0B0;