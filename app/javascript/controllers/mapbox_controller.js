import { Controller } from "@hotwired/stimulus"
import mapboxgl from 'mapbox-gl'
import MapboxGeocoder from "@mapbox/mapbox-gl-geocoder"

// Connects to data-controller="mapbox"
export default class extends Controller {
  static values ={
    apiKey: String,
    markers: Array
  }

  connect() {
    mapboxgl.accessToken = this.apiKeyValue
    // console.log(this.apiKeyValue);

    this.map = new mapboxgl.Map({
      container: this.element,
      style: "mapbox://styles/mapbox/streets-v10",
      center: [139.6917, 35.6895],
      zoom: 4
    })

    this.#addMarkersToMap()
    this.#fitMapToMarkers()

    this.map.addControl(new MapboxGeocoder({ accessToken: mapboxgl.accessToken,
    mapboxgl: mapboxgl }))


  }

  #addMarkersToMap() {
    this.markersValue.forEach((marker) => {
      // Create a popup
      const popup = new mapboxgl.Popup().setHTML(marker.popup_html)
      // to define marker.popup_html go back to your controller

      // Create a custom marker
      const customMarker = document.createElement("div")
      customMarker.innerHTML = marker.marker_html

      // const currentURL = window.location.href
      // const lastChar = currentURL.charAt(currentURL.length-1)
      // const includedRoute = 'http://localhost:3000/events'
      const path = window.location.pathname

      new mapboxgl.Marker(customMarker)
        .setLngLat([ marker.lng, marker.lat ])
        .setPopup(popup)
        .addTo(this.map)

      // if (Number.isInteger(parseInt(lastChar, 10))) {
      if (path !== '/events') {
        new mapboxgl.Marker(customMarker)
        .setLngLat([ marker.lng, marker.lat ])
        .setPopup(popup)
        .addTo(this.map)
        .togglePopup()
      }
    })
  }

  #fitMapToMarkers() {
    const bounds = new mapboxgl.LngLatBounds()
    this.markersValue.forEach(marker => bounds.extend([ marker.lng, marker.lat ]))
    this.map.fitBounds(bounds, { padding: 70, maxZoom: 15, duration: 500 })
  }

}
