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
                Appointment Requests
              </h1>
              <p class="mt-3 text-lg text-slate-600">Review and manage patient appointment requests with ease</p>
            </div>
            
            <!-- Stats Cards -->
            <div class="flex flex-wrap gap-4">
              <div class="group relative overflow-hidden bg-gradient-to-br from-amber-400 to-orange-500 px-6 py-4 rounded-xl shadow-lg hover:shadow-xl transition-all duration-300 transform hover:scale-105">
                <div class="absolute inset-0 bg-white/20 opacity-0 group-hover:opacity-100 transition-opacity duration-300"></div>
                <div class="relative">
                  <div class="text-sm font-medium text-amber-100">Pending</div>
                  <div class="text-3xl font-bold text-white">{{ pendingCount }}</div>
                </div>
                <div class="absolute -top-2 -right-2 w-8 h-8 bg-white/20 rounded-full"></div>
              </div>
              
              <div class="group relative overflow-hidden bg-gradient-to-br from-blue-500 to-indigo-600 px-6 py-4 rounded-xl shadow-lg hover:shadow-xl transition-all duration-300 transform hover:scale-105">
                <div class="absolute inset-0 bg-white/20 opacity-0 group-hover:opacity-100 transition-opacity duration-300"></div>
                <div class="relative">
                  <div class="text-sm font-medium text-blue-100">Total</div>
                  <div class="text-3xl font-bold text-white">{{ appointmentsStore.appointments.length }}</div>
                </div>
                <div class="absolute -top-2 -right-2 w-8 h-8 bg-white/20 rounded-full"></div>
              </div>
            </div>
          </div>
        </div>
      </div>

      <!-- Enhanced Filter Tabs -->
      <div class="px-4 sm:px-0 mb-8">
        <div class="sm:hidden">
          <select v-model="activeFilter" class="w-full rounded-xl border-0 bg-white/80 backdrop-blur-sm shadow-lg ring-1 ring-slate-200 focus:ring-2 focus:ring-blue-500 px-4 py-3">
            <option value="all">All Appointments</option>
            <option value="pending">Pending</option>
            <option value="approved">Approved</option>
            <option value="rejected">Rejected</option>
          </select>
        </div>
        
        <div class="hidden sm:block">
          <div class="backdrop-blur-sm bg-white/60 rounded-2xl p-2 shadow-lg border border-white/20">
            <nav class="flex space-x-2">
              <button
                v-for="filter in filters"
                :key="filter.key"
                @click="activeFilter = filter.key"
                :class="[
                  'relative px-6 py-3 rounded-xl font-medium text-sm transition-all duration-300 transform hover:scale-105',
                  activeFilter === filter.key
                    ? 'bg-gradient-to-r from-blue-500 to-indigo-600 text-white shadow-lg'
                    : 'text-slate-600 hover:bg-white/80 hover:text-slate-900 hover:shadow-md'
                ]"
              >
                {{ filter.label }}
                <span
                  v-if="filter.count > 0"
                  :class="[
                    'ml-2 px-2 py-0.5 rounded-full text-xs font-bold',
                    activeFilter === filter.key
                      ? 'bg-white/20 text-white'
                      : 'bg-slate-100 text-slate-700'
                  ]"
                >
                  {{ filter.count }}
                </span>
              </button>
            </nav>
          </div>
        </div>
      </div>

      <!-- Loading State with pulse animation -->
      <div v-if="appointmentsStore.loading" class="flex justify-center py-16">
        <div class="relative">
          <div class="animate-spin rounded-full h-16 w-16 border-4 border-blue-200 border-t-blue-600"></div>
          <div class="absolute inset-0 rounded-full border-4 border-transparent border-t-indigo-400 animate-spin" style="animation-delay: -0.5s"></div>
        </div>
      </div>

      <!-- Error State -->
      <div v-else-if="appointmentsStore.error" class="backdrop-blur-sm bg-red-50/80 border border-red-200/50 rounded-2xl p-6 mb-6 shadow-lg">
        <div class="flex items-center">
          <div class="flex-shrink-0 w-10 h-10 bg-red-100 rounded-full flex items-center justify-center">
            <svg class="h-6 w-6 text-red-600" viewBox="0 0 20 20" fill="currentColor">
              <path fill-rule="evenodd" d="M10 18a8 8 0 100-16 8 8 0 000 16zM8.707 7.293a1 1 0 00-1.414 1.414L8.586 10l-1.293 1.293a1 1 0 101.414 1.414L10 11.414l1.293 1.293a1 1 0 001.414-1.414L11.414 10l1.293-1.293a1 1 0 00-1.414-1.414L10 8.586 8.707 7.293z" clip-rule="evenodd" />
            </svg>
          </div>
          <div class="ml-4">
            <h3 class="text-lg font-semibold text-red-800">{{ appointmentsStore.error }}</h3>
          </div>
        </div>
      </div>

      <!-- Success Message -->
      <div v-if="successMessage" class="backdrop-blur-sm bg-emerald-50/80 border border-emerald-200/50 rounded-2xl p-6 mb-6 shadow-lg animate-fade-in">
        <div class="flex items-center">
          <div class="flex-shrink-0 w-10 h-10 bg-emerald-100 rounded-full flex items-center justify-center">
            <svg class="h-6 w-6 text-emerald-600" viewBox="0 0 20 20" fill="currentColor">
              <path fill-rule="evenodd" d="M10 18a8 8 0 100-16 8 8 0 000 16zm3.707-9.293a1 1 0 00-1.414-1.414L9 10.586 7.707 9.293a1 1 0 00-1.414 1.414l2 2a1 1 0 001.414 0l4-4z" clip-rule="evenodd" />
            </svg>
          </div>
          <div class="ml-4">
            <h3 class="text-lg font-semibold text-emerald-800">{{ successMessage }}</h3>
          </div>
        </div>
      </div>

      <!-- Appointments List -->
      <div v-else class="mt-6">
        <!-- Empty State -->
        <div v-if="filteredAppointments.length === 0" class="text-center py-16 backdrop-blur-sm bg-white/70 rounded-2xl shadow-xl border border-white/20">
          <div class="w-24 h-24 mx-auto mb-6 bg-gradient-to-br from-slate-100 to-slate-200 rounded-full flex items-center justify-center">
            <svg class="w-12 h-12 text-slate-400" stroke="currentColor" fill="none" viewBox="0 0 48 48">
              <path d="M34 40h10v-4a6 6 0 00-10.712-3.714M34 40H14m20 0v-4a9.971 9.971 0 00-.712-3.714M14 40H4v-4a6 6 0 0110.713-3.714M14 40v-4c0-1.313.253-2.566.713-3.714m0 0A10.003 10.003 0 0124 26c4.21 0 7.813 2.602 9.287 6.286M14 32.286A10.003 10.003 0 0124 26c4.21 0 7.813 2.602 9.287 6.286" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" />
            </svg>
          </div>
          <h3 class="text-xl font-semibold text-slate-700 mb-2">No appointments found</h3>
          <p class="text-slate-500">
            {{ activeFilter === 'all' ? 'No appointment requests yet.' : `No ${activeFilter} appointments.` }}
          </p>
        </div>

        <!-- Appointments Grid -->
        <div v-else class="grid gap-6">
          <div
            v-for="appointment in filteredAppointments"
            :key="appointment.id"
            class="group backdrop-blur-sm bg-white/80 rounded-2xl shadow-lg hover:shadow-xl border border-white/20 transition-all duration-300 transform hover:scale-[1.02] overflow-hidden"
          >
            <div class="p-6 space-y-6">
              <!-- Header -->
              <div class="flex items-center justify-between">
                <div class="flex items-center space-x-4">
                  <div class="relative">
                    <div class="h-14 w-14 rounded-full bg-gradient-to-br from-blue-400 to-indigo-500 flex items-center justify-center shadow-lg">
                      <span class="text-lg font-bold text-white">
                        {{ appointment.patient?.name?.charAt(0)?.toUpperCase() || 'P' }}
                      </span>
                    </div>
                    <div class="absolute -bottom-1 -right-1 w-5 h-5 bg-emerald-400 rounded-full border-2 border-white"></div>
                  </div>
                  <div>
                    <h3 class="text-lg font-semibold text-slate-800">
                      {{ appointment.patient?.name || 'Unknown Patient' }}
                    </h3>
                    <p class="text-slate-500">{{ appointment.patient?.email || 'No email' }}</p>
                  </div>
                </div>
                <StatusBadge :status="appointment.status" />
              </div>

              <!-- Information Grid -->
              <div class="grid grid-cols-1 lg:grid-cols-2 gap-6">
                <div class="space-y-4">
                  <div class="group/info hover:bg-slate-50/50 rounded-xl p-4 transition-colors duration-200">
                    <h4 class="text-sm font-semibold text-slate-500 uppercase tracking-wide mb-2 flex items-center">
                      <svg class="w-4 h-4 mr-2 text-blue-500" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M8 7V3a1 1 0 011-1h6a1 1 0 011 1v4h3a2 2 0 012 2v11a2 2 0 01-2 2H5a2 2 0 01-2-2V9a2 2 0 012-2h3z" />
                      </svg>
                      Preferred Date
                    </h4>
                    <p class="text-slate-800 font-medium">{{ formatDate(appointment.preferred_date) }}</p>
                  </div>
                  
                  <div class="group/info hover:bg-slate-50/50 rounded-xl p-4 transition-colors duration-200">
                    <h4 class="text-sm font-semibold text-slate-500 uppercase tracking-wide mb-2 flex items-center">
                      <svg class="w-4 h-4 mr-2 text-green-500" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 8v4l3 3m6-3a9 9 0 11-18 0 9 9 0 0118 0z" />
                      </svg>
                      Requested
                    </h4>
                    <p class="text-slate-800 font-medium">{{ formatDate(appointment.created_at) }}</p>
                  </div>
                </div>

                <div class="space-y-4">
                  <div class="group/info hover:bg-slate-50/50 rounded-xl p-4 transition-colors duration-200">
                    <h4 class="text-sm font-semibold text-slate-500 uppercase tracking-wide mb-2 flex items-center">
                      <svg class="w-4 h-4 mr-2 text-purple-500" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12h6m-6 4h6m2 5H7a2 2 0 01-2-2V5a2 2 0 012-2h5.586a1 1 0 01.707.293l5.414 5.414a1 1 0 01.293.707V19a2 2 0 01-2 2z" />
                      </svg>
                      Reason
                    </h4>
                    <p class="text-slate-800">{{ appointment.reason || 'No reason provided' }}</p>
                  </div>

                  <div v-if="appointment.remarks" class="group/info hover:bg-slate-50/50 rounded-xl p-4 transition-colors duration-200">
                    <h4 class="text-sm font-semibold text-slate-500 uppercase tracking-wide mb-2 flex items-center">
                      <svg class="w-4 h-4 mr-2 text-orange-500" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M7 8h10M7 12h4m1 8l-4-4H5a2 2 0 01-2-2V6a2 2 0 012-2h14a2 2 0 012 2v8a2 2 0 01-2 2h-3l-4 4z" />
                      </svg>
                      Your Remarks
                    </h4>
                    <p class="text-slate-800">{{ appointment.remarks }}</p>
                  </div>
                </div>
              </div>

              <!-- Remarks Input -->
              <div v-if="showRemarksFor === appointment.id" class="backdrop-blur-sm bg-slate-50/80 rounded-xl p-6 border border-slate-200/50 space-y-4">
                <div>
                  <label class="block text-sm font-semibold text-slate-700 mb-3">
                    Add remarks for {{ currentAction }} (optional)
                  </label>
                  <textarea
                    v-model="remarksText"
                    rows="4"
                    class="w-full border-0 rounded-xl bg-white/80 shadow-sm ring-1 ring-slate-200 focus:ring-2 focus:ring-blue-500 placeholder-slate-400 resize-none transition-all duration-200"
                    :placeholder="`Add ${currentAction === 'approval' ? 'confirmation details or instructions' : 'reason for rejection'}...`"
                  ></textarea>
                </div>
                <div class="flex justify-end space-x-3">
                  <button
                    @click="cancelAction"
                    :disabled="processing"
                    class="px-6 py-3 rounded-xl font-medium text-slate-600 bg-white/80 hover:bg-slate-100 border border-slate-200 transition-all duration-200 disabled:opacity-50 transform hover:scale-105"
                  >
                    Cancel
                  </button>
                  <button
                    @click="confirmAction"
                    :disabled="processing"
                    :class="[
                      'px-6 py-3 rounded-xl font-medium transition-all duration-200 disabled:opacity-50 transform hover:scale-105',
                      currentAction === 'approval' 
                        ? 'bg-gradient-to-r from-emerald-500 to-green-600 text-white shadow-lg hover:shadow-xl' 
                        : 'bg-gradient-to-r from-red-500 to-pink-600 text-white shadow-lg hover:shadow-xl'
                    ]"
                  >
                    {{ processing ? 'Processing...' : `Confirm ${currentAction}` }}
                  </button>
                </div>
              </div>

              <!-- Action Buttons -->
              <div v-else-if="appointment.status === 'pending'" class="flex justify-end space-x-3 pt-4 border-t border-slate-100">
                <button
                  @click="startRejectAction(appointment)"
                  :disabled="processing || showRemarksFor"
                  class="px-6 py-3 rounded-xl font-medium text-red-600 bg-red-50 hover:bg-red-100 border border-red-200 transition-all duration-200 disabled:opacity-50 transform hover:scale-105"
                >
                  Reject
                </button>
                <button
                  @click="startApproveAction(appointment)"
                  :disabled="processing || showRemarksFor"
                  class="px-6 py-3 rounded-xl font-medium bg-gradient-to-r from-emerald-500 to-green-600 text-white shadow-lg hover:shadow-xl transition-all duration-200 disabled:opacity-50 transform hover:scale-105"
                >
                  Approve
                </button>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script setup>
import { ref, computed, onMounted } from 'vue'
import { useAppointmentsStore } from '../stores/appointments'
import NavBar from '../components/NavBar.vue'
import StatusBadge from '../components/StatusBadge.vue'

const appointmentsStore = useAppointmentsStore()

const activeFilter = ref('all')
const showRemarksFor = ref(null)
const currentAction = ref('')
const selectedAppointment = ref(null)
const remarksText = ref('')
const processing = ref(false)
const successMessage = ref('')

const filters = computed(() => [
  { key: 'all', label: 'All', count: appointmentsStore.appointments.length },
  { key: 'pending', label: 'Pending', count: pendingCount.value },
  { key: 'approved', label: 'Approved', count: appointmentsStore.appointments.filter(a => a.status === 'approved').length },
  { key: 'rejected', label: 'Rejected', count: appointmentsStore.appointments.filter(a => a.status === 'rejected').length }
])

const pendingCount = computed(() => {
  return appointmentsStore.appointments.filter(a => a.status === 'pending').length
})

const filteredAppointments = computed(() => {
  if (activeFilter.value === 'all') {
    return appointmentsStore.appointments
  }
  return appointmentsStore.appointments.filter(appointment => appointment.status === activeFilter.value)
})

const formatDate = (dateString) => {
  if (!dateString) return 'N/A'
  try {
    const date = new Date(dateString)
    return date.toLocaleDateString('en-US', {
      year: 'numeric',
      month: 'long',
      day: 'numeric',
      hour: '2-digit',
      minute: '2-digit'
    })
  } catch (error) {
    console.error('Date formatting error:', error)
    return dateString
  }
}

const startApproveAction = (appointment) => {
  console.log('Starting approve action for:', appointment)
  selectedAppointment.value = appointment
  currentAction.value = 'approval'
  remarksText.value = ''
  showRemarksFor.value = appointment.id
}

const startRejectAction = (appointment) => {
  console.log('Starting reject action for:', appointment)
  selectedAppointment.value = appointment
  currentAction.value = 'rejection'
  remarksText.value = ''
  showRemarksFor.value = appointment.id
}

const cancelAction = () => {
  showRemarksFor.value = null
  selectedAppointment.value = null
  currentAction.value = ''
  remarksText.value = ''
}

const confirmAction = async () => {
  if (!selectedAppointment.value || processing.value) return

  processing.value = true
  console.log(`Processing ${currentAction.value} for appointment:`, selectedAppointment.value.id)

  try {
    const updateData = {
      status: currentAction.value === 'approval' ? 'approved' : 'rejected',
      remarks: remarksText.value.trim() || null
    }

    console.log('Update data:', updateData)

    const result = await appointmentsStore.updateAppointment(selectedAppointment.value.id, updateData)
    
    console.log('Update result:', result)

    if (result.success) {
      successMessage.value = `Appointment ${currentAction.value === 'approval' ? 'approved' : 'rejected'} successfully!`
      cancelAction()
      
      // Clear success message after 3 seconds
      setTimeout(() => {
        successMessage.value = ''
      }, 3000)
      
      // Refresh appointments to get latest data
      await appointmentsStore.fetchAppointments()
    } else {
      console.error('Failed to update appointment:', result.error)
      alert(result.error || 'Failed to update appointment')
    }
  } catch (error) {
    console.error('Error updating appointment:', error)
    alert('An error occurred while updating the appointment')
  } finally {
    processing.value = false
  }
}

onMounted(async () => {
  console.log('Fetching appointments...')
  await appointmentsStore.fetchAppointments()
  console.log('Appointments loaded:', appointmentsStore.appointments)
})
</script>

<style scoped>
@keyframes fade-in {
  from { opacity: 0; transform: translateY(-10px); }
  to { opacity: 1; transform: translateY(0); }
}

.animate-fade-in {
  animation: fade-in 0.5s ease-out;
}
</style>