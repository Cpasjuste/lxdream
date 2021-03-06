/**
 * $Id$
 *
 * Cocoa builds need to use different paths from ordinary builds, since
 * the message catalogs, default config, etc are all bundle-relative.
 * Otherwise paths use the standard unix install paths
 *
 * Copyright (c) 2008 Nathan Keynes.
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 */

#include <string.h>
#include <glib.h>

#include "lxdream.h"
#include "lxpaths.h"

#include <AppKit/AppKit.h>

static char *bundle_resource_path = NULL;
static char *bundle_plugin_path = NULL;
static char *user_data_path = NULL;

static char *get_bundle_resource_path()
{
    if( bundle_resource_path == NULL ) {
        NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
        NSString *resourcePath = [[NSBundle mainBundle] resourcePath];
        bundle_resource_path = strdup([resourcePath UTF8String]);
        [pool release];
    }
    return bundle_resource_path;    
}

const char *get_sysconf_path()
{
    return get_bundle_resource_path();
}

const char *get_locale_path()
{
    return get_bundle_resource_path();
}

const char *get_plugin_path()
{
    if( bundle_plugin_path == NULL ) {
        NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
        NSString *pluginPath = [[NSBundle mainBundle] builtInPlugInsPath];
        bundle_plugin_path = strdup([pluginPath UTF8String]);
        [pool release];
    }
    return bundle_plugin_path;    
}


const char *get_user_data_path()
{
    if( user_data_path == NULL ) {
        char *home = getenv("HOME");
        user_data_path = g_strdup_printf( "%s/Library/Application Support/Lxdream", home );
    }
    return user_data_path;
}