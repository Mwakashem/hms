<template>
  <div class="min-h-screen bg-gradient-to-br from-blue-50 via-white to-indigo-50">
    <NavBar />
    
    <div class="max-w-3xl mx-auto py-8 px-4 sm:px-6 lg:px-8">
      <!-- Enhanced Header -->
      <div class="mb-8">
        <div class="flex items-center space-x-4 mb-6">
          <router-link
            to="/patient"
            class="inline-flex items-center justify-center w-10 h-10 rounded-full bg-white shadow-md hover:shadow-lg transition-all duration-200 text-gray-600 hover:text-blue-600 group"
          >
            <svg class="w-5 h-5 transform group-hover:-translate-x-0.5 transition-transform" fill="none" stroke="currentColor" viewBox="0 0 24 24">
              <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15 19l-7-7 7-7" />
            </svg>
          </router-link>
          <div>
            <h1 class="text-4xl font-bold bg-gradient-to-r from-blue-600 to-indigo-600 bg-clip-text text-transparent">
              Request New Appointment
            </h1>
            <p class="mt-2 text-lg text-gray-600">Schedule your visit with our healthcare professionals</p>
          </div>
        </div>
        
        <!-- Progress indicator -->
        <div class="bg-white rounded-lg p-4 shadow-sm border border-gray-100">
          <div class="flex items-center space-x-3">
            <div class="flex-shrink-0">
              <div class="w-8 h-8 bg-blue-100 rounded-full flex items-center justify-center">
                <svg class="w-4 h-4 text-blue-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                  <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 6v6m0 0v6m0-6h6m-6 0H6" />
                </svg>
              </div>
            </div>
            <div>
              <p class="text-sm font-medium text-gray-900">Step 1 of 1</p>
              <p class="text-sm text-gray-500">Complete the form below to submit your request</p>
            </div>
          </div>
        </div>
      </div>

      <!-- Enhanced Form -->
      <div class="bg-white rounded-2xl shadow-xl border border-gray-100 overflow-hidden">
        <div class="px-8 py-6 bg-gradient-to-r from-blue-500 to-indigo-600">
          <h2 class="text-xl font-semibold text-white">Appointment Details</h2>
          <p class="text-blue-100 mt-1">Please fill in all required information</p>
        </div>

        <form @submit.prevent="handleSubmit" class="p-8 space-y-8">
          <!-- Doctor Selection with Enhanced Styling -->
          <div class="space-y-3">
            <label for="doctor" class="block text-sm font-semibold text-gray-900 flex items-center">
              <svg class="w-4 h-4 mr-2 text-blue-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M16 7a4 4 0 11-8 0 4 4 0 018 0zM12 14a7 7 0 00-7 7h14a7 7 0 00-7-7z" />
              </svg>
              Select Doctor
              <span class="text-red-500 ml-1">*</span>
            </label>
            <div class="relative">
              <select 
                v-model="form.doctor_id" 
                required 
                class="w-full px-4 py-3 text-gray-900 bg-gray-50 border border-gray-200 rounded-xl focus:ring-2 focus:ring-blue-500 focus:border-transparent transition-all duration-200 appearance-none cursor-pointer hover:bg-gray-100"
                :class="validationErrors.doctor_id ? 'border-red-300 bg-red-50 focus:ring-red-500' : ''"
              >
                <option disabled value="">Choose a doctor...</option>
                <option v-if="appointmentsStore.doctors.length === 0" disabled>Loading doctors...</option>
                <option
                  v-for="doctor in appointmentsStore.doctors.doctors"
                  :key="doctor.id"
                  :value="doctor.id"
                >
                  {{ doctor.name }}
                </option>
              </select>
              <div class="absolute inset-y-0 right-0 flex items-center px-3 pointer-events-none">
                <svg class="w-5 h-5 text-gray-400" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                  <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19 9l-7 7-7-7" />
                </svg>
              </div>
            </div>
            <p v-if="validationErrors.doctor_id" class="text-sm text-red-600 flex items-center">
              <svg class="w-4 h-4 mr-1" fill="currentColor" viewBox="0 0 20 20">
                <path fill-rule="evenodd" d="M18 10a8 8 0 11-16 0 8 8 0 0116 0zm-7 4a1 1 0 11-2 0 1 1 0 012 0zm-1-9a1 1 0 00-1 1v4a1 1 0 102 0V6a1 1 0 00-1-1z" clip-rule="evenodd" />
              </svg>
              {{ validationErrors.doctor_id[0] }}
            </p>
          </div>

          <!-- Preferred Date with Enhanced Styling -->
          <div class="space-y-3">
            <label for="preferred_date" class="block text-sm font-semibold text-gray-900 flex items-center">
              <svg class="w-4 h-4 mr-2 text-blue-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M8 7V3m8 4V3m-9 8h10M5 21h14a2 2 0 002-2V7a2 2 0 00-2-2H5a2 2 0 00-2 2v12a2 2 0 002 2z" />
              </svg>
              Preferred Date & Time
              <span class="text-red-500 ml-1">*</span>
            </label>
            <div class="relative">
              <input
                id="preferred_date"
                v-model="form.preferred_date"
                type="datetime-local"
                :min="minDateTime"
                class="w-full px-4 py-3 text-gray-900 bg-gray-50 border border-gray-200 rounded-xl focus:ring-2 focus:ring-blue-500 focus:border-transparent transition-all duration-200 hover:bg-gray-100"
                :class="validationErrors.preferred_date ? 'border-red-300 bg-red-50 focus:ring-red-500' : ''"
                required
              />
            </div>
            <p v-if="validationErrors.preferred_date" class="text-sm text-red-600 flex items-center">
              <svg class="w-4 h-4 mr-1" fill="currentColor" viewBox="0 0 20 20">
                <path fill-rule="evenodd" d="M18 10a8 8 0 11-16 0 8 8 0 0116 0zm-7 4a1 1 0 11-2 0 1 1 0 012 0zm-1-9a1 1 0 00-1 1v4a1 1 0 102 0V6a1 1 0 00-1-1z" clip-rule="evenodd" />
              </svg>
              {{ validationErrors.preferred_date[0] }}
            </p>
            <p class="text-sm text-gray-500 flex items-center">
              <svg class="w-4 h-4 mr-1" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M13 16h-1v-4h-1m1-4h.01M21 12a9 9 0 11-18 0 9 9 0 0118 0z" />
              </svg>
              Please select a date and time that works best for you
            </p>
          </div>

          <!-- Reason with Enhanced Styling -->
          <div class="space-y-3">
            <label for="reason" class="block text-sm font-semibold text-gray-900 flex items-center">
              <svg class="w-4 h-4 mr-2 text-blue-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12h6m-6 4h6m2 5H7a2 2 0 01-2-2V5a2 2 0 012-2h5.586a1 1 0 01.707.293l5.414 5.414a1 1 0 01.293.707V19a2 2 0 01-2 2z" />
              </svg>
              Reason for Appointment
              <span class="text-red-500 ml-1">*</span>
            </label>
            <div class="relative">
              <textarea
                id="reason"
                v-model="form.reason"
                rows="5"
                class="w-full px-4 py-3 text-gray-900 bg-gray-50 border border-gray-200 rounded-xl focus:ring-2 focus:ring-blue-500 focus:border-transparent transition-all duration-200 resize-none hover:bg-gray-100"
                :class="validationErrors.reason ? 'border-red-300 bg-red-50 focus:ring-red-500' : ''"
                placeholder="Please describe the reason for your appointment in detail. Include any symptoms, concerns, or specific issues you'd like to discuss..."
                required
              ></textarea>
            </div>
            <div class="flex justify-between items-center">
              <p v-if="validationErrors.reason" class="text-sm text-red-600 flex items-center">
                <svg class="w-4 h-4 mr-1" fill="currentColor" viewBox="0 0 20 20">
                  <path fill-rule="evenodd" d="M18 10a8 8 0 11-16 0 8 8 0 0116 0zm-7 4a1 1 0 11-2 0 1 1 0 012 0zm-1-9a1 1 0 00-1 1v4a1 1 0 102 0V6a1 1 0 00-1-1z" clip-rule="evenodd" />
                </svg>
                {{ validationErrors.reason[0] }}
              </p>
              <p class="text-sm text-gray-500 ml-auto" :class="{ 'text-red-500': form.reason.length > 500, 'text-green-600': form.reason.length >= 10 && form.reason.length <= 500 }">
                {{ form.reason.length }}/500 characters
              </p>
            </div>
          </div>

          <!-- Enhanced Error Display -->
          <div v-if="appointmentsStore.error" class="rounded-xl bg-red-50 border border-red-200 p-4">
            <div class="flex">
              <div class="flex-shrink-0">
                <svg class="h-5 w-5 text-red-400" viewBox="0 0 20 20" fill="currentColor">
                  <path fill-rule="evenodd" d="M10 18a8 8 0 100-16 8 8 0 000 16zM8.707 7.293a1 1 0 00-1.414 1.414L8.586 10l-1.293 1.293a1 1 0 101.414 1.414L10 11.414l1.293 1.293a1 1 0 001.414-1.414L11.414 10l1.293-1.293a1 1 0 00-1.414-1.414L10 8.586 8.707 7.293z" clip-rule="evenodd" />
                </svg>
              </div>
              <div class="ml-3">
                <h3 class="text-sm font-medium text-red-800">
                  {{ appointmentsStore.error }}
                </h3>
              </div>
            </div>
          </div>

          <!-- Enhanced Success Message -->
          <div v-if="showSuccess" class="rounded-xl bg-green-50 border border-green-200 p-6">
            <div class="flex">
              <div class="flex-shrink-0">
                <div class="w-10 h-10 bg-green-100 rounded-full flex items-center justify-center">
                  <svg class="h-6 w-6 text-green-600" viewBox="0 0 20 20" fill="currentColor">
                    <path fill-rule="evenodd" d="M10 18a8 8 0 100-16 8 8 0 000 16zm3.707-9.293a1 1 0 00-1.414-1.414L9 10.586 7.707 9.293a1 1 0 00-1.414 1.414l2 2a1 1 0 001.414 0l4-4z" clip-rule="evenodd" />
                  </svg>
                </div>
              </div>
              <div class="ml-4">
                <h3 class="text-lg font-semibold text-green-800">
                  Appointment Request Submitted!
                </h3>
                <p class="mt-2 text-sm text-green-700">
                  Your appointment request has been successfully sent to the doctor for review. You'll receive a confirmation shortly.
                </p>
              </div>
            </div>
          </div>

          <!-- Enhanced Action Buttons -->
          <div class="flex flex-col sm:flex-row sm:justify-end space-y-3 sm:space-y-0 sm:space-x-4 pt-6 border-t border-gray-200">
            <router-link
              to="/patient"
              class="inline-flex items-center justify-center px-6 py-3 border border-gray-300 text-base font-medium rounded-xl text-gray-700 bg-white hover:bg-gray-50 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-blue-500 transition-all duration-200 shadow-sm"
            >
              <svg class="w-4 h-4 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M6 18L18 6M6 6l12 12" />
              </svg>
              Cancel
            </router-link>
            <button
              type="submit"
              :disabled="appointmentsStore.loading || !isFormValid"
              class="inline-flex items-center justify-center px-8 py-3 border border-transparent text-base font-medium rounded-xl text-white bg-gradient-to-r from-blue-600 to-indigo-600 hover:from-blue-700 hover:to-indigo-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-blue-500 disabled:opacity-50 disabled:cursor-not-allowed transition-all duration-200 shadow-lg hover:shadow-xl transform hover:-translate-y-0.5"
            >
              <span v-if="appointmentsStore.loading" class="flex items-center">
                <svg class="animate-spin -ml-1 mr-3 h-5 w-5 text-white" fill="none" viewBox="0 0 24 24">
                  <circle class="opacity-25" cx="12" cy="12" r="10" stroke="currentColor" stroke-width="4"></circle>
                  <path class="opacity-75" fill="currentColor" d="M4 12a8 8 0 018-8V0C5.373 0 0 5.373 0 12h4zm2 5.291A7.962 7.962 0 014 12H0c0 3.042 1.135 5.824 3 7.938l3-2.647z"></path>
                </svg>
                Submitting Request...
              </span>
              <span v-else class="flex items-center">
                <svg class="w-4 h-4 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                  <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 19l9 2-9-18-9 18 9-2zm0 0v-8" />
                </svg>
                Submit Request
              </span>
            </button>
          </div>
        </form>
      </div>

      <!-- Additional Information Card -->
      <div class="mt-8 bg-blue-50 border border-blue-200 rounded-xl p-6">
        <div class="flex items-start">
          <div class="flex-shrink-0">
            <svg class="w-6 h-6 text-blue-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
              <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M13 16h-1v-4h-1m1-4h.01M21 12a9 9 0 11-18 0 9 9 0 0118 0z" />
            </svg>
          </div>
          <div class="ml-4">
            <h3 class="text-lg font-semibold text-blue-900">What happens next?</h3>
            <ul class="mt-3 text-sm text-blue-800 space-y-2">
              <li class="flex items-center">
                <svg class="w-4 h-4 mr-2 text-blue-600" fill="currentColor" viewBox="0 0 20 20">
                  <path fill-rule="evenodd" d="M10 18a8 8 0 100-16 8 8 0 000 16zm3.707-9.293a1 1 0 00-1.414-1.414L9 10.586 7.707 9.293a1 1 0 00-1.414 1.414l2 2a1 1 0 001.414 0l4-4z" clip-rule="evenodd" />
                </svg>
                Your request will be reviewed by the selected doctor
              </li>
              <li class="flex items-center">
                <svg class="w-4 h-4 mr-2 text-blue-600" fill="currentColor" viewBox="0 0 20 20">
                  <path fill-rule="evenodd" d="M10 18a8 8 0 100-16 8 8 0 000 16zm3.707-9.293a1 1 0 00-1.414-1.414L9 10.586 7.707 9.293a1 1 0 00-1.414 1.414l2 2a1 1 0 001.414 0l4-4z" clip-rule="evenodd" />
                </svg>
                You'll receive a confirmation email within 24 hours
              </li>
              <li class="flex items-center">
                <svg class="w-4 h-4 mr-2 text-blue-600" fill="currentColor" viewBox="0 0 20 20">
                  <path fill-rule="evenodd" d="M10 18a8 8 0 100-16 8 8 0 000 16zm3.707-9.293a1 1 0 00-1.414-1.414L9 10.586 7.707 9.293a1 1 0 00-1.414 1.414l2 2a1 1 0 001.414 0l4-4z" clip-rule="evenodd" />
                </svg>
                Alternative times may be suggested if your preferred slot is unavailable
              </li>
            </ul>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script setup>
import { reactive, ref, computed, onMounted } from 'vue'
import { useRouter } from 'vue-router'
import { useAppointmentsStore } from '../stores/appointments'
import NavBar from '../components/NavBar.vue'

const router = useRouter()
const appointmentsStore = useAppointmentsStore()

const form = reactive({
  doctor_id: '',
  preferred_date: '',
  reason: ''
})

const validationErrors = ref({})
const showSuccess = ref(false)

const minDateTime = computed(() => {
  const now = new Date()
  now.setMinutes(now.getMinutes() + 60) // Minimum 1 hour from now
  return now.toISOString().slice(0, 16)
})

const isFormValid = computed(() => {
  return form.doctor_id && 
         form.preferred_date && 
         form.reason.length >= 10 && 
         form.reason.length <= 500
})

const handleSubmit = async () => {
  appointmentsStore.clearError()
  validationErrors.value = {}

  const result = await appointmentsStore.createAppointment({
    doctor_id: parseInt(form.doctor_id),
    preferred_date: form.preferred_date,
    reason: form.reason
  })

  if (result.success) {
    showSuccess.value = true
    // Reset form
    form.doctor_id = ''
    form.preferred_date = ''
    form.reason = ''
    
    // Redirect after 2 seconds
    setTimeout(() => {
      router.push('/patient')
    }, 2000)
  } else {
    if (result.validationErrors) {
      validationErrors.value = result.validationErrors
    }
  }
}

onMounted(async () => {
  await appointmentsStore.fetchDoctors()
    console.log('Doctors loaded:', appointmentsStore.doctors)
  appointmentsStore.clearError()
})
</script>