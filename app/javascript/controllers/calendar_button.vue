<template>
  <div>
    <!-- Use the add-to-calendar-button component -->
    <add-to-calendar-button
    name="Sample Event"
    description="Play with me!"
    startDate="2024-02-20"
    startTime="10:15"
    endTime="17:45"
    timeZone="Asia/Tokyo"
    location="World Wide Web"
    options="'Apple','Google','Outlook.com'"
    buttonStyle="round"
    >
</add-to-calendar-button>
  </div>
</template>

<script>
import 'add-to-calendar-button';

export default {
  name: 'YourComponentName',
  // other component options...
};
</script>
