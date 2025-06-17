<template>
  <div class="min-h-screen bg-gradient-to-br from-slate-50 via-blue-50 to-indigo-50">
    <NavBar />
    
    <div class="max-w-7xl mx-auto py-8 sm:px-6 lg:px-8">
      <!-- Header with glassmorphism effect -->
      <div class="px-4 py-8 sm:px-0">
        <div class="backdrop-blur-sm bg-white/70 rounded-2xl p-8 shadow-xl border border-white/20">
          <div class="flex flex-col lg:flex-row lg:justify-between lg:items-center gap-6">
            <div>
              <h1 class="text-4xl font-bold bg-gradient-to-r from-slate-900 via-blue-900 to-indigo-900 bg-clip-text text-transparent">
                My Appointments
              </h1>
              <p class="mt-3 text-lg text-slate-600">Manage your appointment requests with ease</p>
            </div>
            
            <!-- New Appointment Button -->
            <router-link
              to="/appointments/create"
              class="group relative overflow-hidden bg-gradient-to-r from-blue-500 to-indigo-600 text-white px-8 py-4 rounded-xl font-semibold shadow-lg hover:shadow-xl transition-all duration-300 transform hover:scale-105 inline-flex items-center"
            >
              <div class="absolute inset-0 bg-white/20 opacity-0 group-hover:opacity-100 transition-opacity duration-300"></div>
              <svg class="w-5 h-5 mr-3 relative z-10" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 6v6m0 0v6m0-6h6m-6 0H6" />
              </svg>
              <span class="relative z-10">New Appointment</span>
              <div class="absolute -top-2 -right-2 w-8 h-8 bg-white/20 rounded-full"></div>
            </router-link>
          </div>
        </div>
      </div>

      <!-- Loading State with enhanced animation -->
      <div v-if="appointmentsStore.loading" class="flex justify-center py-16">
        <div class="relative">
          <div class="animate-spin rounded-full h-16 w-16 border-4 border-blue-200 border-t-blue-600"></div>
          <div class="absolute inset-0 rounded-full border-4 border-transparent border-t-indigo-400 animate-spin" style="animation-delay: -0.5s"></div>
          <div class="absolute inset-2 rounded-full border-2 border-transparent border-t-purple-300 animate-spin" style="animation-delay: -1s"></div>
        </div>
      </div>

      <!-- Error State -->
      <div v-else-if="appointmentsStore.error" class="backdrop-blur-sm bg-red-50/80 border border-red-200/50 rounded-2xl p-6 mb-6 shadow-lg">
        <div class="flex items-center">
          <div class="flex-shrink-0 w-12 h-12 bg-red-100 rounded-full flex items-center justify-center">
            <svg class="h-6 w-6 text-red-600" viewBox="0 0 20 20" fill="currentColor">
              <path fill-rule="evenodd" d="M10 18a8 8 0 100-16 8 8 0 000 16zM8.707 7.293a1 1 0 00-1.414 1.414L8.586 10l-1.293 1.293a1 1 0 101.414 1.414L10 11.414l1.293 1.293a1 1 0 001.414-1.414L11.414 10l1.293-1.293a1 1 0 00-1.414-1.414L10 8.586 8.707 7.293z" clip-rule="evenodd" />
            </svg>
          </div>
          <div class="ml-4">
            <h3 class="text-lg font-semibold text-red-800">{{ appointmentsStore.error }}</h3>
          </div>
        </div>
      </div>

      <!-- Appointments Content -->
      <div v-else class="mt-8">
        <!-- Empty State -->
        <div v-if="appointmentsStore.appointments.length === 0" class="text-center py-20 backdrop-blur-sm bg-white/70 rounded-2xl shadow-xl border border-white/20">
          <div class="relative mb-8">
            <div class="w-32 h-32 mx-auto bg-gradient-to-br from-slate-100 via-blue-100 to-indigo-100 rounded-full flex items-center justify-center shadow-lg">
              <svg class="w-16 h-16 text-slate-400" stroke="currentColor" fill="none" viewBox="0 0 48 48">
                <path d="M34 40h10v-4a6 6 0 00-10.712-3.714M34 40H14m20 0v-4a9.971 9.971 0 00-.712-3.714M14 40H4v-4a6 6 0 0110.713-3.714M14 40v-4c0-1.313.253-2.566.713-3.714m0 0A10.003 10.003 0 0124 26c4.21 0 7.813 2.602 9.287 6.286M14 32.286A10.003 10.003 0 0124 26c4.21 0 7.813 2.602 9.287 6.286" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" />
              </svg>
            </div>
            <div class="absolute -top-2 -right-8 w-6 h-6 bg-blue-200 rounded-full animate-pulse"></div>
            <div class="absolute -bottom-4 -left-6 w-4 h-4 bg-indigo-200 rounded-full animate-pulse" style="animation-delay: 0.5s"></div>
          </div>
          
          <h3 class="text-2xl font-bold text-slate-700 mb-3">No appointments yet</h3>
          <p class="text-lg text-slate-500 mb-8 max-w-md mx-auto">
            Ready to schedule your first appointment? Get started by creating a new appointment request.
          </p>
          
          <router-link
            to="/appointments/create"
            class="group relative overflow-hidden bg-gradient-to-r from-emerald-500 to-teal-600 text-white px-8 py-4 rounded-xl font-semibold shadow-lg hover:shadow-xl transition-all duration-300 transform hover:scale-105 inline-flex items-center"
          >
            <div class="absolute inset-0 bg-white/20 opacity-0 group-hover:opacity-100 transition-opacity duration-300"></div>
            <svg class="w-5 h-5 mr-3 relative z-10" fill="none" stroke="currentColor" viewBox="0 0 24 24">
              <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 6v6m0 0v6m0-6h6m-6 0H6" />
            </svg>
            <span class="relative z-10">Create Your First Appointment</span>
          </router-link>
        </div>

        <!-- Appointments Grid -->
        <div v-else class="grid gap-6">
          <div
            v-for="appointment in appointmentsStore.appointments"
            :key="appointment.id"
            class="group backdrop-blur-sm bg-white/80 rounded-2xl shadow-lg hover:shadow-xl border border-white/20 transition-all duration-300 transform hover:scale-[1.02] overflow-hidden"
          >
            <div class="p-6">
              <!-- Header -->
              <div class="flex items-start justify-between mb-6">
                <div class="flex items-center space-x-4">
                  <div class="relative">
                    <div class="h-14 w-14 rounded-full bg-gradient-to-br from-emerald-400 to-teal-500 flex items-center justify-center shadow-lg">
                      <svg class="w-7 h-7 text-white" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M16 7a4 4 0 11-8 0 4 4 0 018 0zM12 14a7 7 0 00-7 7h14a7 7 0 00-7-7z" />
                      </svg>
                    </div>
                    <div class="absolute -bottom-1 -right-1 w-5 h-5 bg-blue-400 rounded-full border-2 border-white flex items-center justify-center">
                      <svg class="w-3 h-3 text-white" fill="currentColor" viewBox="0 0 20 20">
                        <path fill-rule="evenodd" d="M6.267 3.455a3.066 3.066 0 001.745-.723 3.066 3.066 0 013.976 0 3.066 3.066 0 001.745.723 3.066 3.066 0 012.812 2.812c.051.643.304 1.254.723 1.745a3.066 3.066 0 010 3.976 3.066 3.066 0 00-.723 1.745 3.066 3.066 0 01-2.812 2.812 3.066 3.066 0 00-1.745.723 3.066 3.066 0 01-3.976 0 3.066 3.066 0 00-1.745-.723 3.066 3.066 0 01-2.812-2.812 3.066 3.066 0 00-.723-1.745 3.066 3.066 0 010-3.976 3.066 3.066 0 00.723-1.745 3.066 3.066 0 012.812-2.812zm7.44 5.252a1 1 0 00-1.414-1.414L9 10.586 7.707 9.293a1 1 0 00-1.414 1.414l2 2a1 1 0 001.414 0l4-4z" clip-rule="evenodd" />
                      </svg>
                    </div>
                  </div>
                  <div>
                    <div class="flex items-center space-x-3 mb-1">
                      <h3 class="text-xl font-bold text-slate-800">
                        Dr. {{ appointment.doctor.name }}
                      </h3>
                      <StatusBadge :status="appointment.status" />
                    </div>
                    <p class="text-slate-500 font-medium">{{ appointment.doctor.specialization || 'General Practice' }}</p>
                  </div>
                </div>
              </div>

              <!-- Appointment Details -->
              <div class="grid grid-cols-1 lg:grid-cols-2 gap-6 mb-6">
                <div class="space-y-4">
                  <div class="group/detail hover:bg-slate-50/50 rounded-xl p-4 transition-colors duration-200">
                    <h4 class="text-sm font-semibold text-slate-500 uppercase tracking-wide mb-2 flex items-center">
                      <svg class="w-4 h-4 mr-2 text-indigo-500" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M8 7V3a1 1 0 011-1h6a1 1 0 011 1v4h3a2 2 0 012 2v11a2 2 0 01-2 2H5a2 2 0 01-2-2V9a2 2 0 012-2h3z" />
                      </svg>
                      Appointment Date
                    </h4>
                    <p class="text-lg font-semibold text-slate-800">{{ formatDate(appointment.preferred_date) }}</p>
                  </div>
                  
                  <div class="group/detail hover:bg-slate-50/50 rounded-xl p-4 transition-colors duration-200">
                    <h4 class="text-sm font-semibold text-slate-500 uppercase tracking-wide mb-2 flex items-center">
                      <svg class="w-4 h-4 mr-2 text-purple-500" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12h6m-6 4h6m2 5H7a2 2 0 01-2-2V5a2 2 0 012-2h5.586a1 1 0 01.707.293l5.414 5.414a1 1 0 01.293.707V19a2 2 0 01-2 2z" />
                      </svg>
                      Reason for Visit
                    </h4>
                    <p class="text-slate-700 leading-relaxed">{{ appointment.reason }}</p>
                  </div>
                </div>

                <div class="space-y-4">
                  <div v-if="appointment.remarks" class="group/detail hover:bg-slate-50/50 rounded-xl p-4 transition-colors duration-200">
                    <h4 class="text-sm font-semibold text-slate-500 uppercase tracking-wide mb-2 flex items-center">
                      <svg class="w-4 h-4 mr-2 text-emerald-500" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M7 8h10M7 12h4m1 8l-4-4H5a2 2 0 01-2-2V6a2 2 0 012-2h14a2 2 0 012 2v8a2 2 0 01-2 2h-3l-4 4z" />
                      </svg>
                      Doctor's Remarks
                    </h4>
                    <div class="bg-gradient-to-r from-emerald-50 to-teal-50 border-l-4 border-emerald-400 p-4 rounded-r-lg">
                      <p class="text-emerald-800 font-medium">{{ appointment.remarks }}</p>
                    </div>
                  </div>

                  <div class="group/detail hover:bg-slate-50/50 rounded-xl p-4 transition-colors duration-200">
                    <h4 class="text-sm font-semibold text-slate-500 uppercase tracking-wide mb-2 flex items-center">
                      <svg class="w-4 h-4 mr-2 text-blue-500" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M13 16h-1v-4h-1m1-4h.01M21 12a9 9 0 11-18 0 9 9 0 0118 0z" />
                      </svg>
                      Status Update
                    </h4>
                    <div class="flex items-center space-x-3">
                      <div class="flex-shrink-0">
                        <div :class="[
                          'w-3 h-3 rounded-full',
                          appointment.status === 'pending' ? 'bg-amber-400 animate-pulse' :
                          appointment.status === 'approved' ? 'bg-emerald-400' :
                          'bg-red-400'
                        ]"></div>
                      </div>
                      <p class="text-slate-700 capitalize font-medium">
                        {{ appointment.status === 'pending' ? 'Awaiting approval' : 
                           appointment.status === 'approved' ? 'Confirmed' : 'Rejected' }}
                      </p>
                    </div>
                  </div>
                </div>
              </div>

              <!-- Action Button -->
              <div class="flex justify-end pt-4 border-t border-slate-100">
                <router-link
                  :to="{ name: 'AppointmentDetails', params: { id: appointment.id } }"
                  class="group relative overflow-hidden bg-gradient-to-r from-slate-600 to-slate-700 text-white px-6 py-3 rounded-xl font-medium shadow-md hover:shadow-lg transition-all duration-300 transform hover:scale-105 inline-flex items-center"
                >
                  <div class="absolute inset-0 bg-white/10 opacity-0 group-hover:opacity-100 transition-opacity duration-300"></div>
                  <span class="relative z-10 mr-2">View Details</span>
                  <svg class="w-4 h-4 relative z-10 group-hover:translate-x-1 transition-transform duration-200" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 5l7 7-7 7" />
                  </svg>
                </router-link>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script setup>
import { onMounted } from 'vue'
import { useAppointmentsStore } from '../stores/appointments'
import NavBar from '../components/NavBar.vue'
import StatusBadge from '../components/StatusBadge.vue'

const appointmentsStore = useAppointmentsStore()

const formatDate = (dateString) => {
  const date = new Date(dateString)
  return date.toLocaleDateString('en-US', {
    year: 'numeric',
    month: 'long',
    day: 'numeric',
    hour: '2-digit',
    minute: '2-digit'
  })
}

onMounted(async () => {
  await appointmentsStore.fetchAppointments()
  console.log('Appointments fetched:', appointmentsStore.appointments)
  if (appointmentsStore.error) {
    console.error('Error fetching appointments:', appointmentsStore.error)
  }
})
</script>

<style scoped>
@keyframes fadeIn {
  from { opacity: 0; transform: translateY(20px); }
  to { opacity: 1; transform: translateY(0); }
}

.fade-in {
  animation: fadeIn 0.6s ease-out;
}
</style>