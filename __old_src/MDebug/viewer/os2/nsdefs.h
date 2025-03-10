/* -*- Mode: C++; tab-width: 2; indent-tabs-mode: nil; c-basic-offset: 2 -*- */
/* ***** BEGIN LICENSE BLOCK *****
 * Version: NPL 1.1/GPL 2.0/LGPL 2.1
 *
 * The contents of this file are subject to the Netscape Public License
 * Version 1.1 (the "License"); you may not use this file except in
 * compliance with the License. You may obtain a copy of the License at
 * http://www.mozilla.org/NPL/
 *
 * Software distributed under the License is distributed on an "AS IS" basis,
 * WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
 * for the specific language governing rights and limitations under the
 * License.
 *
 * The Original Code is mozilla.org code.
 *
 * The Initial Developer of the Original Code is 
 * Netscape Communications Corporation.
 * Portions created by the Initial Developer are Copyright (C) 1998
 * the Initial Developer. All Rights Reserved.
 *
 * Contributor(s):
 *
 * Alternatively, the contents of this file may be used under the terms of
 * either the GNU General Public License Version 2 or later (the "GPL"), or 
 * the GNU Lesser General Public License Version 2.1 or later (the "LGPL"),
 * in which case the provisions of the GPL or the LGPL are applicable instead
 * of those above. If you wish to allow use of your version of this file only
 * under the terms of either the GPL or the LGPL, and not to allow others to
 * use your version of this file under the terms of the NPL, indicate your
 * decision by deleting the provisions above and replace them with the notice
 * and other provisions required by the GPL or the LGPL. If you do not delete
 * the provisions above, a recipient may use your version of this file under
 * the terms of any one of the NPL, the GPL or the LGPL.
 *
 * ***** END LICENSE BLOCK ***** */

#ifndef NSDEFS_H
#define NSDEFS_H

#ifdef _DEBUG
#define INCL_WINERRORS
#endif
#include <os2.h>

#ifdef _DEBUG
  #define BREAK_TO_DEBUGGER           _interrupt(3)
#else   
  #define BREAK_TO_DEBUGGER
#endif  

#ifdef _DEBUG
  #define VERIFY(exp)                 ((exp) ? (void)0: (WinGetLastError((HAB)0), BREAK_TO_DEBUGGER))
#else   // !_DEBUG
  #define VERIFY(exp)                 (exp)
#endif  // !_DEBUG

#define WC_BUTTON_STRING      "#3" //string equivalent to WC_BUTTON
#define WC_STATIC_STRING      "#5" //string equivalent to WC_STATIC
#define WC_ENTRYFIELD_STRING  "#6" //string equivalent to WC_ENTRYFIELD

extern "C" {
PVOID APIENTRY WinQueryProperty(HWND hwnd, PCSZ  pszNameOrAtom);

PVOID APIENTRY WinRemoveProperty(HWND hwnd, PCSZ  pszNameOrAtom);

BOOL  APIENTRY WinSetProperty(HWND hwnd, PCSZ  pszNameOrAtom,
                              PVOID pvData, ULONG ulFlags);
}


#endif  // NSDEFS_H


