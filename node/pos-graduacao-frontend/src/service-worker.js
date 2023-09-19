const VERSION = 'V7';
const STATIC_CACHE = `static-${VERSION}`;
const DINAMYC_CACHE = `dynamic-${VERSION}`;

const STATIC_FILES = ['/', '/index.html'];
const urlListForNetworkFirst = ['https://source.unsplash.com/']; //external url e/or apis
const urlListForCacheFirst = ['https://localhost:5050']; //localhost e/or hosted domain

self.addEventListener('install', (event) => {
  console.log('[Service Worker] Installing Service Worker ...', { event });
  self.skipWaiting();
  clearOldCache();
  event.waitUntil(cacheResources());
});

self.addEventListener('activate', (event) => {
  console.log('[Service Worker] Activating Service Worker ....', { event });
  event.waitUntil(clearOldCache());
  return self.clients.claim();
});

self.addEventListener('fetch', (event) => {
  trimCache(DINAMYC_CACHE, 50);
  const requestUrl = event.request.url;

  if (urlListForNetworkFirst.find((url) => requestUrl.includes(url)))
    return event.respondWith(NetworkFirst(event, DINAMYC_CACHE));

  if (urlListForCacheFirst.find((url) => requestUrl.includes(url)))
    return event.respondWith(CacheFirst(event, STATIC_CACHE));

  return event.respondWith(CacheFirst(event, DINAMYC_CACHE));
});

const cacheResources = async () => {
  const cache = await caches.open(STATIC_CACHE);
  return cache.addAll(STATIC_FILES);
};

const clearOldCache = async () => {
  let cacheNamesList = [];
  cacheNamesList = await caches.keys();
  cacheNamesList = cacheNamesList.filter((name) => name !== STATIC_CACHE);
  cacheNamesList = cacheNamesList.filter((name) => name !== DINAMYC_CACHE);
  cacheNamesList.map((cacheName) => caches.delete(cacheName));
};

const trimCache = async (cacheName, maxItems) => {
  const cache = await caches.open(cacheName);
  const cacheKeys = await cache.keys();

  if (cacheKeys.length > maxItems) {
    console.log('[Service Worker] Deleting item from cache', cacheKeys[0]);
    await cache.delete(cacheKeys[0]);
    trimCache(cacheName, maxItems);
  }
};

const NetworkFirst = async (event, storage) => {
  return fetch(event.request)
    .then((res) =>
      caches.open(storage).then((cache) => {
        cache.put(event.request.url, res.clone());
        return res;
      }),
    )
    .catch(() =>
      caches
        .match(event.request)
        .catch(() => caches.open(STATIC_CACHE).then((cache) => cache.match('/index.html'))),
    );
};

const CacheFirst = (event, storage) => {
  return caches.match(event.request).then((response) => {
    if (response) return response;

    return fetch(event.request)
      .then((res) => {
        return caches.open(storage).then((cache) => {
          cache.put(event.request.url, res.clone());
          return res;
        });
      })
      .catch((err) => {
        if (event.request.headers.get('accept').includes('text/html')) {
          return caches.open(STATIC_CACHE).then((cache) => cache.match('/index.html'));
        }
      });
  });
};
