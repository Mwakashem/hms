<template>
  <div v-if="isOpen" class="fixed inset-0 z-50 overflow-y-auto">
    <div class="flex items-end justify-center min-h-screen pt-4 px-4 pb-20 text-center sm:block sm:p-0">
      <!-- Background overlay -->
      <div 
        class="fixed inset-0 bg-gray-500 bg-opacity-75 transition-opacity"
        @click="closeModal"
      ></div>

      <!-- Modal panel -->
      <div class="inline-block align-bottom bg-white rounded-lg text-left overflow-hidden shadow-xl transform transition-all sm:my-8 sm:align-middle sm:max-w-lg sm:w-full">
        <div class="bg-white px-4 pt-5 pb-4 sm:p-6 sm:pb-4">
          <div class="sm:flex sm:items-start">
            <div class="mx-auto flex-shrink-0 flex items-center justify-center h-12 w-12 rounded-full sm:mx-0 sm:h-10 sm:w-10"
                 :class="iconBgClass">
              <svg class="h-6 w-6" :class="iconClass" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                <path v-if="action === 'confirm'" stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M5 13l4 4L19 7" />
                <path v-else-if="action === 'complete'" stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12l2 2 4-4m6 2a9 9 0 11-18 0 9 9 0 0118 0z" />
                <path v-else stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M6 18L18 6M6 6l12 12" />
              </svg>
            </div>
            <div class="mt-3 text-center sm:mt-0 sm:ml-4 sm:text-left">
              <h3 class="text-lg leading-6 font-medium text-gray-900">
                {{ modalTitle }}
              </h3>
              <div class="mt-2">
                <p class="text-sm text-gray-500">
                  {{ modalMessage }}
                </p>
              </div>
            </div>
          </div>
        </div>
        
        <div class="bg-gray-50 px-4 py-3 sm:px-6 sm:flex sm:flex-row-reverse">
          <button
            type="button"
            @click="confirmAction"
            :disabled="loading"
            class="w-full inline-flex justify-center rounded-md border border-transparent shadow-sm px-4 py-2 text-base font-medium text-white focus:outline-none focus:ring-2 focus:ring-offset-2 sm:ml-3 sm:w-auto sm:text-sm disabled:opacity-50"
            :class="confirmButtonClass"
          >
            <svg v-if="loading" class="animate-spin -ml-1 mr-3 h-5 w-5 text-white" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24">
              <circle class="opacity-25" cx="12" cy="12" r="10" stroke="currentColor" stroke-width="4"></circle>
              <path class="opacity-75" fill="currentColor" d="M4 12a8 8 0 018-8V0C5.373 0 0 5.373 0 12h4zm2 5.291A7.962 7.962 0 014 12H0c0 3.042 1.135 5.824 3 7.938l3-2.647z"></path>
            </svg>
            {{ loading ? 'Processing...' : confirmButtonText }}
          </button>
          <button
            type="button"
            @click="closeModal"
            :disabled="loading"
            class="mt-3 w-full inline-flex justify-center rounded-md border border-gray-300 shadow-sm px-4 py-2 bg-white text-base font-medium text-gray-700 hover:bg-gray-50 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-indigo-500 sm:mt-0 sm:ml-3 sm:w-auto sm:text-sm disabled:opacity-50"
          >
            Cancel
          </button>
        </div>
      </div>
    </div>
  </div>
</template>

<script setup>
/* eslint-disable no-undef */
import { computed, ref } from 'vue'

const props = defineProps({
  isOpen: {
    type: Boolean,
    required: true
  },
  action: {
    type: String,
    required: true,
    validator: (value) => ['confirm', 'complete', 'cancel'].includes(value)
  },
  appointment: {
    type: Object,
    default: () => ({})
  }
})

const emit = defineEmits(['close', 'confirm'])

const loading = ref(false)

const modalTitle = computed(() => {
  const titles = {
    confirm: 'Confirm Appointment',
    complete: 'Complete Appointment',
    cancel: 'Cancel Appointment'
  }
  return titles[props.action]
})

const modalMessage = computed(() => {
  const messages = {
    confirm: 'Are you sure you want to confirm this appointment?',
    complete: 'Are you sure you want to mark this appointment as completed?',
    cancel: 'Are you sure you want to cancel this appointment? This action cannot be undone.'
  }
  return messages[props.action]
})

const confirmButtonText = computed(() => {
  const texts = {
    confirm: 'Confirm',
    complete: 'Complete',
    cancel: 'Cancel Appointment'
  }
  return texts[props.action]
})

const confirmButtonClass = computed(() => {
  const classes = {
    confirm: 'bg-blue-600 hover:bg-blue-700 focus:ring-blue-500',
    complete: 'bg-green-600 hover:bg-green-700 focus:ring-green-500',
    cancel: 'bg-red-600 hover:bg-red-700 focus:ring-red-500'
  }
  return classes[props.action]
})

const iconBgClass = computed(() => {
  const classes = {
    confirm: 'bg-blue-100',
    complete: 'bg-green-100',
    cancel: 'bg-red-100'
  }
  return classes[props.action]
})

const iconClass = computed(() => {
  const classes = {
    confirm: 'text-blue-600',
    complete: 'text-green-600',
    cancel: 'text-red-600'
  }
  return classes[props.action]
})

const closeModal = () => {
  if (!loading.value) {
    emit('close')
  }
}

const confirmAction = async () => {
  loading.value = true
  try {
    await emit('confirm', props.appointment)
    emit('close')
  } catch (error) {
    console.error('Action failed:', error)
  } finally {
    loading.value = false
  }
}
</script>