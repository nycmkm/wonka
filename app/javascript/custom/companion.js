console.log("Companion loaded!")
if (navigator.serviceWorker) {
  console.log("Companion loaded??")
  navigator.serviceWorker.register("/service-worker.js", { scope: "/" })
    .then(() => navigator.serviceWorker.ready)
    .then((registration) => {
      if ("SyncManager" in window) {
        registration.sync.register("sync-forms");
      } else {
        console.log("[Companion] This browser does not support background sync.")
      }
    }).then(() => console.log("[Companion]", "Service worker registered!"));
}
