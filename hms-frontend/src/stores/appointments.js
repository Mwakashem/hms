import { defineStore } from 'pinia'
import { ref } from 'vue'
import api from '../api/config'

export const useAppointmentsStore = defineStore('appointments', () => {
  const appointments = ref([])
  const doctors = ref([])
  const loading = ref(false)
  const error = ref(null)

  const fetchAppointments = async () => {
    try {
      loading.value = true
      error.value = null
      
      const response = await api.get('/appointments')
      
      // Handle paginated response
      if (response.data.appointments && response.data.appointments.data) {
        appointments.value = response.data.appointments.data
      } else if (response.data.data) {
        appointments.value = response.data.data
      } else {
        appointments.value = response.data
      }
      
      return { success: true }
    } catch (err) {
      error.value = err.response?.data?.message || 'Failed to fetch appointments'
      return { success: false, error: error.value }
    } finally {
      loading.value = false
    }
  }

  const fetchAppointmentById = async (id) => {
    try {
      loading.value = true
      error.value = null
      
      const response = await api.get(`/appointments/${id}`)
      
      let appointmentData = null
      
      // Handle different response structures
      if (response.data && (response.data.id || response.data.appointment)) {
        appointmentData = response.data.appointment || response.data
      } else if (response.data.data) {
        appointmentData = response.data.data
      } else {
        appointmentData = response.data
      }
      
      // Add to local appointments array if not exists
      if (appointmentData) {
        const existingIndex = appointments.value.findIndex(apt => apt.id === parseInt(id))
        if (existingIndex === -1) {
          appointments.value.push(appointmentData)
        } else {
          appointments.value[existingIndex] = appointmentData
        }
      }
      
      return { success: true, data: appointmentData }
    } catch (err) {
      error.value = err.response?.data?.message || 'Failed to fetch appointment'
      return { success: false, error: error.value }
    } finally {
      loading.value = false
    }
  }

  const createAppointment = async (appointmentData) => {
    try {
      loading.value = true
      error.value = null
      
      const response = await api.post('/appointments', appointmentData)
      
      return { success: true, data: response.data }
    } catch (err) {
      console.log(err)
      const errorMessage = err.response?.data?.message || 'Failed to create appointment'
      const validationErrors = err.response?.data?.errors || {}
      
      error.value = errorMessage
      return { 
        success: false, 
        error: errorMessage,
        validationErrors 
      }
    } finally {
      loading.value = false
    }
  }

  const updateAppointment = async (appointmentId, updateData) => {
    try {
      loading.value = true
      error.value = null
      
      const response = await api.put(`/appointments/${appointmentId}`, updateData)
      
      // Update the appointment in the local array
      const index = appointments.value.findIndex(apt => apt.id === appointmentId)
      if (index !== -1) {
        appointments.value[index] = response.data.appointment || response.data
      }
      
      return { success: true, data: response.data }
    } catch (err) {
      const errorMessage = err.response?.data?.message || 'Failed to update appointment'
      const validationErrors = err.response?.data?.errors || {}
      
      error.value = errorMessage
      return { 
        success: false, 
        error: errorMessage,
        validationErrors 
      }
    } finally {
      loading.value = false
    }
  }

  const fetchDoctors = async () => {
    try {
      const response = await api.get('/doctors')
      doctors.value = response.data
      return { success: true }
    } catch (err) {
      error.value = err.response?.data?.message || 'Failed to fetch doctors'
      return { success: false, error: error.value }
    }
  }

  const getAppointmentById = (id) => {
    return appointments.value.find(apt => apt.id === parseInt(id))
  }

  const clearError = () => {
    error.value = null
  }

  return {
    appointments,
    doctors,
    loading,
    error,
    fetchAppointments,
    fetchAppointmentById,
    createAppointment,
    updateAppointment,
    fetchDoctors,
    getAppointmentById,
    clearError
  }
})