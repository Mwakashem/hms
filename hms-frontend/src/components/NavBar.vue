<template>
  <nav class="bg-white shadow-lg">
    <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
      <div class="flex justify-between h-16">
        <div class="flex items-center">
          <div class="flex-shrink-0 flex items-center">
            <div class="h-8 w-8 bg-primary-600 rounded-full flex items-center justify-center">
              <svg class="h-5 w-5 text-white" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M16 7a4 4 0 11-8 0 4 4 0 018 0zM12 14a7 7 0 00-7 7h14a7 7 0 00-7-7z" />
              </svg>
            </div>
            <span class="ml-2 text-xl font-bold text-gray-900">HMS</span>
          </div>
          
          <div class="hidden md:block ml-10">
            <div class="flex items-baseline space-x-4">
              <router-link 
                to="/dashboard" 
                class="text-gray-900 hover:text-primary-600 px-3 py-2 rounded-md text-sm font-medium"
                :class="{ 'text-primary-600': $route.path === '/dashboard' }"
              >
                Dashboard
              </router-link>
              
              <router-link 
                v-if="authStore.user?.role === 'patient'"
                to="/appointments/create" 
                class="text-gray-900 hover:text-primary-600 px-3 py-2 rounded-md text-sm font-medium"
                :class="{ 'text-primary-600': $route.path === '/appointments/create' }"
              >
                Book Appointment
              </router-link>
            </div>
          </div>
        </div>
        
        <div class="flex items-center">
          <div class="flex items-center space-x-4">
            <span class="text-sm text-gray-700">
              {{ authStore.user?.name || 'User' }}
            </span>
            <span class="inline-flex items-center px-2.5 py-0.5 rounded-full text-xs font-medium bg-primary-100 text-primary-800">
              {{ authStore.user?.role || 'Guest' }}
            </span>
            <button 
              @click="handleLogout"
              class="text-gray-500 hover:text-gray-700 px-3 py-2 rounded-md text-sm font-medium"
            >
              Logout
            </button>
          </div>
        </div>
      </div>
    </div>
  </nav>
</template>

<script setup>
import { useRouter } from 'vue-router'
import { useAuthStore } from '../stores/auth'

const router = useRouter()
const authStore = useAuthStore()

const handleLogout = async () => {
  await authStore.logout()
  router.push('/login')
}
</script>