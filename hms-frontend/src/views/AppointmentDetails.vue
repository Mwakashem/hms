<template>
  <div class="min-h-screen bg-gradient-to-br from-blue-50 via-white to-indigo-50">
    <NavBar />

    <div class="max-w-5xl mx-auto py-8 px-4 sm:px-6 lg:px-8">
      <!-- Header -->
      <div class="mb-8">
        <div class="flex items-center space-x-4 mb-6">
          <router-link
            :to="authStore.isPatient ? '/patient' : '/doctor'"
            class="group flex items-center justify-center w-10 h-10 rounded-full bg-white shadow-md hover:shadow-lg transition-all duration-200 hover:bg-blue-50"
          >
            <svg class="w-5 h-5 text-gray-600 group-hover:text-blue-600 transition-colors" fill="none" stroke="currentColor" viewBox="0 0 24 24">
              <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15 19l-7-7 7-7" />
            </svg>
          </router-link>
          <div>
            <h1 class="text-4xl font-bold text-gray-900 tracking-tight">Appointment Details</h1>
            <p class="text-gray-600 mt-1">View and manage appointment information</p>
          </div>
        </div>
      </div>

      <!-- Loading State -->
      <div v-if="loading" class="flex flex-col items-center justify-center py-20">
        <div class="relative">
          <div class="animate-spin rounded-full h-16 w-16 border-4 border-blue-200"></div>
          <div class="animate-spin rounded-full h-16 w-16 border-4 border-blue-600 border-t-transparent absolute top-0 left-0"></div>
        </div>
        <p class="text-gray-600 mt-4 text-lg">Loading appointment details...</p>
      </div>

      <!-- Error State -->
      <div v-else-if="error" class="max-w-2xl mx-auto">
        <div class="bg-gradient-to-r from-red-50 to-pink-50 border border-red-200 rounded-xl p-6 shadow-lg">
          <div class="flex items-start space-x-4">
            <div class="flex-shrink-0">
              <div class="w-12 h-12 bg-red-100 rounded-full flex items-center justify-center">
                <svg class="h-6 w-6 text-red-600" viewBox="0 0 20 20" fill="currentColor">
                  <path fill-rule="evenodd" d="M10 18a8 8 0 100-16 8 8 0 000 16zM8.707 7.293a1 1 0 00-1.414 1.414L8.586 10l-1.293 1.293a1 1 0 101.414 1.414L10 11.414l1.293 1.293a1 1 0 001.414-1.414L11.414 10l1.293-1.293a1 1 0 00-1.414-1.414L10 8.586 8.707 7.293z" clip-rule="evenodd" />
                </svg>
              </div>
            </div>
            <div>
              <h3 class="text-lg font-semibold text-red-800 mb-1">Error Loading Appointment</h3>
              <p class="text-red-700">{{ error }}</p>
            </div>
          </div>
        </div>
      </div>

      <!-- Appointment Details -->
      <div v-else-if="appointment" class="space-y-6">
        <!-- Status Banner -->
        <div class="bg-white rounded-xl shadow-sm border border-gray-200 overflow-hidden">
          <div :class="[
            'px-6 py-4 border-l-4',
            appointment.status === 'confirmed' ? 'bg-green-50 border-green-400' :
            appointment.status === 'pending' ? 'bg-yellow-50 border-yellow-400' :
            appointment.status === 'cancelled' ? 'bg-red-50 border-red-400' :
            'bg-gray-50 border-gray-400'
          ]">
            <div class="flex items-center justify-between">
              <div class="flex items-center space-x-3">
                <div :class="[
                  'w-3 h-3 rounded-full',
                  appointment.status === 'confirmed' ? 'bg-green-400' :
                  appointment.status === 'pending' ? 'bg-yellow-400' :
                  appointment.status === 'cancelled' ? 'bg-red-400' :
                  'bg-gray-400'
                ]"></div>
                <h2 class="text-lg font-semibold text-gray-900 capitalize">
                  Appointment {{ appointment.status || 'Unknown' }}
                </h2>
              </div>
              <span :class="[
                'px-3 py-1 rounded-full text-xs font-medium',
                appointment.status === 'confirmed' ? 'bg-green-100 text-green-800' :
                appointment.status === 'pending' ? 'bg-yellow-100 text-yellow-800' :
                appointment.status === 'cancelled' ? 'bg-red-100 text-red-800' :
                'bg-gray-100 text-gray-800'
              ]">
                {{ appointment.status || 'Unknown' }}
              </span>
            </div>
          </div>
        </div>

        <!-- Main Content Grid -->
        <div class="grid grid-cols-1 lg:grid-cols-3 gap-6">
          <!-- Primary Information -->
          <div class="lg:col-span-2 space-y-6">
            <!-- Participants -->
            <div class="bg-white rounded-xl shadow-sm border border-gray-200 overflow-hidden">
              <div class="bg-gradient-to-r from-blue-500 to-indigo-600 px-6 py-4">
                <h3 class="text-lg font-semibold text-white flex items-center">
                  <svg class="w-5 h-5 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 4.354a4 4 0 110 5.292M15 21H3v-1a6 6 0 0112 0v1zm0 0h6v-1a6 6 0 00-9-5.197m13.5-9a2.5 2.5 0 11-5 0 2.5 2.5 0 015 0z" />
                  </svg>
                  Participants
                </h3>
              </div>
              <div class="p-6">
                <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                  <!-- Doctor -->
                  <div class="flex items-start space-x-4">
                    <div class="w-12 h-12 bg-blue-100 rounded-full flex items-center justify-center flex-shrink-0">
                      <svg class="w-6 h-6 text-blue-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M16 7a4 4 0 11-8 0 4 4 0 018 0zM12 14a7 7 0 00-7 7h14a7 7 0 00-7-7z" />
                      </svg>
                    </div>
                    <div>
                      <p class="text-sm font-medium text-gray-500 mb-1">Doctor</p>
                      <p class="text-lg font-semibold text-gray-900">
                        {{ appointment.doctor?.name || 'Not assigned' }}
                      </p>
                      <p class="text-sm text-gray-600">Healthcare Provider</p>
                    </div>
                  </div>

                  <!-- Patient -->
                  <div class="flex items-start space-x-4">
                    <div class="w-12 h-12 bg-green-100 rounded-full flex items-center justify-center flex-shrink-0">
                      <svg class="w-6 h-6 text-green-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M16 7a4 4 0 11-8 0 4 4 0 018 0zM12 14a7 7 0 00-7 7h14a7 7 0 00-7-7z" />
                      </svg>
                    </div>
                    <div>
                      <p class="text-sm font-medium text-gray-500 mb-1">Patient</p>
                      <p class="text-lg font-semibold text-gray-900">
                        {{ appointment.patient?.name || 'Not specified' }}
                      </p>
                      <p class="text-sm text-gray-600">Patient</p>
                    </div>
                  </div>
                </div>
              </div>
            </div>

            <!-- Appointment Reason -->
            <div class="bg-white rounded-xl shadow-sm border border-gray-200 overflow-hidden">
              <div class="bg-gradient-to-r from-purple-500 to-pink-600 px-6 py-4">
                <h3 class="text-lg font-semibold text-white flex items-center">
                  <svg class="w-5 h-5 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12h6m-6 4h6m2 5H7a2 2 0 01-2-2V5a2 2 0 012-2h5.586a1 1 0 01.707.293l5.414 5.414a1 1 0 01.293.707V19a2 2 0 01-2 2z" />
                  </svg>
                  Reason for Visit
                </h3>
              </div>
              <div class="p-6">
                <p class="text-gray-800 leading-relaxed">
                  {{ appointment.reason || 'No specific reason provided' }}
                </p>
              </div>
            </div>

            <!-- Remarks (if any) -->
            <div v-if="appointment.remarks" class="bg-white rounded-xl shadow-sm border border-gray-200 overflow-hidden">
              <div class="bg-gradient-to-r from-orange-500 to-red-600 px-6 py-4">
                <h3 class="text-lg font-semibold text-white flex items-center">
                  <svg class="w-5 h-5 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M7 8h10M7 12h4m1 8l-4-4H5a2 2 0 01-2-2V6a2 2 0 012-2h14a2 2 0 012 2v8a2 2 0 01-2 2h-3l-4 4z" />
                  </svg>
                  Additional Notes
                </h3>
              </div>
              <div class="p-6">
                <p class="text-gray-800 leading-relaxed">{{ appointment.remarks }}</p>
              </div>
            </div>
          </div>

          <!-- Sidebar -->
          <div class="space-y-6">
            <!-- Date & Time -->
            <div class="bg-white rounded-xl shadow-sm border border-gray-200 overflow-hidden">
              <div class="bg-gradient-to-r from-indigo-500 to-blue-600 px-6 py-4">
                <h3 class="text-lg font-semibold text-white flex items-center">
                  <svg class="w-5 h-5 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M8 7V3m8 4V3m-9 8h10M5 21h14a2 2 0 002-2V7a2 2 0 00-2-2H5a2 2 0 00-2 2v12a2 2 0 002 2z" />
                  </svg>
                  Schedule
                </h3>
              </div>
              <div class="p-6">
                <div class="text-center">
                  <p class="text-sm font-medium text-gray-500 mb-2">Preferred Date & Time</p>
                  <p class="text-lg font-semibold text-gray-900 mb-1">
                    {{ appointment.preferred_date ? formatDate(appointment.preferred_date) : 'Not scheduled' }}
                  </p>
                  <p class="text-md text-blue-600 font-medium">
                    {{ appointment.preferred_date ? formatTime(appointment.preferred_date) : '' }}
                  </p>
                </div>
              </div>
            </div>

            <!-- Quick Actions -->
            
          </div>
        </div>
      </div>

      <!-- No appointment found -->
      <div v-else class="max-w-2xl mx-auto text-center py-12">
        <div class="bg-white rounded-xl shadow-lg p-8">
          <div class="w-24 h-24 bg-gray-100 rounded-full flex items-center justify-center mx-auto mb-6">
            <svg class="w-12 h-12 text-gray-400" fill="none" stroke="currentColor" viewBox="0 0 24 24">
              <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12h6m-6 4h6m2 5H7a2 2 0 01-2-2V5a2 2 0 012-2h5.586a1 1 0 01.707.293l5.414 5.414a1 1 0 01.293.707V19a2 2 0 01-2 2z" />
            </svg>
          </div>
          <h2 class="text-2xl font-bold text-gray-900 mb-2">Appointment Not Found</h2>
          <p class="text-gray-600 mb-6">The requested appointment could not be found in our system.</p>
          <router-link
            :to="authStore.isPatient ? '/patient' : '/doctor'"
            class="inline-flex items-center px-6 py-3 bg-blue-600 hover:bg-blue-700 text-white font-medium rounded-lg transition-colors duration-200 space-x-2"
          >
            <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
              <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M3 12l2-2m0 0l7-7 7 7M5 10v10a1 1 0 001 1h3m10-11l2 2m-2-2v10a1 1 0 01-1 1h-3m-6 0a1 1 0 001-1v-4a1 1 0 011-1h2a1 1 0 011 1v4a1 1 0 001 1m-6 0h6" />
            </svg>
            <span>Go Back Home</span>
          </router-link>
        </div>
      </div>
    </div>
  </div>
</template>

<script setup>
import { onMounted, ref, computed } from 'vue'
import { useRoute } from 'vue-router'
import { useAuthStore } from '../stores/auth'
import { useAppointmentsStore } from '../stores/appointments'
import NavBar from '../components/NavBar.vue'

const route = useRoute()
const authStore = useAuthStore()
const appointmentsStore = useAppointmentsStore()

const loading = ref(true)
const error = ref(null)
const appointment = ref(null)

const formatDate = (datetime) => {
  if (!datetime) return 'N/A'
  try {
    return new Date(datetime).toLocaleDateString('en-US', {
      weekday: 'long',
      year: 'numeric',
      month: 'long',
      day: 'numeric'
    })
  } catch (err) {
    console.error('Date formatting error:', err)
    return datetime
  }
}

const formatTime = (datetime) => {
  if (!datetime) return ''
  try {
    return new Date(datetime).toLocaleTimeString('en-US', {
      hour: '2-digit',
      minute: '2-digit'
    })
  } catch (err) {
    console.error('Time formatting error:', err)
    return ''
  }
}

const formatDateTime = (datetime) => {
  if (!datetime) return 'N/A'
  try {
    return new Date(datetime).toLocaleString('en-US', {
      year: 'numeric',
      month: 'long',
      day: 'numeric',
      hour: '2-digit',
      minute: '2-digit'
    })
  } catch (err) {
    console.error('Date formatting error:', err)
    return datetime
  }
}

onMounted(async () => {
  const id = route.params.id
  
  console.log('Fetching appointment with ID:', id)
  
  if (!id) {
    error.value = 'No appointment ID provided'
    loading.value = false
    return
  }

  try {
    // First check if appointment exists in store
    const existingAppointment = appointmentsStore.getAppointmentById(id)
    if (existingAppointment) {
      console.log('Found appointment in store:', existingAppointment)
      appointment.value = existingAppointment
      loading.value = false
      return
    }

    console.log('Fetching appointment from API...')
    // Use the store method to fetch appointment
    const result = await appointmentsStore.fetchAppointmentById(id)
    
    console.log('API result:', result)
    
    if (result.success && result.data) {
      appointment.value = result.data
      console.log('Appointment loaded successfully:', result.data)
    } else {
      throw new Error(result.error || 'Failed to load appointment')
    }
    
  } catch (err) {
    console.error('Error fetching appointment:', err)
    error.value = err.message || 'Failed to load appointment details.'
  } finally {
    loading.value = false
  }
})
</script>