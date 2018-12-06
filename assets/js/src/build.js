/**
 * Builds, transforms and bundles everything.
 */

const ENTRY_FILE = 'index.js';

const browserify = require('browserify')();
browserify.add(ENTRY_FILE);
browserify.bundle();